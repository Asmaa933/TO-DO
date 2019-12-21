//
//  ViewController.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "TasksVC.h"
#import "TasksData.h"
#import "ManageTasks.h"
#import "AddOrEditTaskVC.h"
#import "AddOrEditDelegate.h"
#import "TasksCell.h"
#import "NSDate+DateExt.h"
#import "DetailsVC.h"
#import "LocalStore.h"
#import <UserNotifications/UserNotifications.h>


@interface TasksVC ()
{
    ManageTasks* manager;
    AddOrEditTaskVC* addOrEdit;
    DetailsVC* detail;
    BOOL isFiltered;
    NSMutableArray* filteredArr;

}
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;
@property (weak, nonatomic) IBOutlet UISearchBar *taskSearch;

@end
bool isGrantedNotificationAccess;
@implementation TasksVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [ManageTasks new];
    addOrEdit = [self.storyboard instantiateViewControllerWithIdentifier:@"addOrEdit"];
    detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    addOrEdit.delegate = self;

       isFiltered = NO;
    [self notificationAuth];
}
- (void)viewWillAppear:(BOOL)animated
{
    [_tasksTable reloadData];
}
-(void) notificationAuth
{
    isGrantedNotificationAccess = false;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionSound+UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}
- (IBAction)addBtnTapped:(UIBarButtonItem *)sender
{
    addOrEdit.isEdit = NO;
    addOrEdit.isGranted = isGrantedNotificationAccess;
    [self.navigationController pushViewController:addOrEdit animated:YES];
    
}
- (void)saveTask:(TasksData *)task :(int)index
{
    if(index == -1)
    {
        [manager addTask:task];
    }
    else
    {
     [manager editTask:task :index];
    }
    [_tasksTable reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numRows = 0 ;
    if(isFiltered)
    {
    numRows =  [filteredArr count];
    }
    else
    {
    numRows = [[manager getAllTasks]count];
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray* arr = [NSMutableArray new];
    TasksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
   if ([[[[manager getAllTasks] objectAtIndex:0] taskName] isEqual: @""])
      {
          cell.accessoryType = UITableViewScrollPositionNone;
          cell.priorityLbl.text = @"" ;
          cell.progressLbl.text = @"" ;
          cell.taskNameLbl.text = @"" ;

      }
      else
      {
          cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
          
      }
    if(isFiltered)
   {
       arr = filteredArr;
       
   }
    else
    {
        arr =[manager getAllTasks];
    }
    cell.taskNameLbl.text = [[arr objectAtIndex:indexPath.row] taskName];
    switch ([[arr objectAtIndex:indexPath.row] priorty]) {
        case 0:
            cell.priorityLbl.text = @"🟢";
            break;
        case 1:
            cell.priorityLbl.text = @"🟡";
            break;
        case 2:
            cell.priorityLbl.text = @"🔴";
            break;
        default:
            cell.priorityLbl.text = @"";
            break;
    }
    switch ([[arr objectAtIndex:indexPath.row] prog]) {
        case 0:
            cell.progressLbl.text = @"🔜";
            break;
        case 1:
            cell.progressLbl.text = @"⏳";
            break;
        case 2:
            cell.progressLbl.text = @"✔️";
            break;
        default:
            cell.priorityLbl.text = @"";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [manager deleteTask:(int) indexPath.row];
        [_tasksTable reloadData];
    }
    }
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[[manager getAllTasks] objectAtIndex:0] taskName] isEqual: @""])
    {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [[[manager getAllTasks] objectAtIndex:indexPath.row] prog] == 2)
    {
        [self showAlert];
    }
    else
    {
    addOrEdit.isEdit = YES;
    addOrEdit.editTask = [[manager getAllTasks] objectAtIndex:indexPath.row];
    addOrEdit.indexNum = (int) indexPath.row;
    [self.navigationController pushViewController:addOrEdit animated:YES];
}
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    detail.detailTask = [[manager getAllTasks] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    isFiltered = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    filteredArr = [NSMutableArray new];
    if(searchText.length == 0)
    {
        TasksData* t1 = [TasksData new];
        t1.priorty = 4;
        t1.prog = 4;
        t1.reminderDate = [[NSDate date]changeToString];
        t1.taskDate = [[NSDate date]changeToString];
        t1.taskName = @"";
        t1.taskDesc = @"";
        [filteredArr  addObject: t1];
        isFiltered=NO;
    }
    
    else
    {
        isFiltered=YES;
        for (int i =0 ; i<[[manager getAllTasks] count]; i++) {
            NSRange stringRange = [[[[manager getAllTasks] objectAtIndex:i]taskName] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(stringRange.location != NSNotFound)
            {
            [filteredArr addObject:[[manager getAllTasks] objectAtIndex:i]];
            }
        }


}
    [_tasksTable reloadData];

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_tasksTable resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isFiltered=NO;
    [_tasksTable reloadData];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
}
-(void)showAlert
{
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Can't edit done task" preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];

        [alert addAction:action1];

        [self presentViewController:alert animated:YES completion:nil];
    }
@end
    
