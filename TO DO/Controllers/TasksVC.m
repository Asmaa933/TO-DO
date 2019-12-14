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
#import "TableViewCell.h"
#import "NSDate+DateExt.h"
#import "DetailsVC.h"

@interface TasksVC ()
{
    
    ManageTasks* manager;
    AddOrEditTaskVC* addOrEdit;
    DetailsVC* detail;
    BOOL isFiltered;
    NSArray* filteredArr;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;
@property (weak, nonatomic) IBOutlet UISearchBar *taskSearch;

@end

@implementation TasksVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    isFiltered = NO;
    manager = [ManageTasks new];
    filteredArr = [NSMutableArray new];
    addOrEdit = [self.storyboard instantiateViewControllerWithIdentifier:@"addOrEdit"];
    detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    addOrEdit.delegate = self;
}

- (IBAction)addBtnTapped:(UIBarButtonItem *)sender
{
    addOrEdit.isEdit = NO;
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
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if ([[[[manager getAllTasks] objectAtIndex:0] taskName] isEqual:@""])
    {
        cell.accessoryType = UITableViewScrollPositionNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
    }
    cell.taskName.text = [[[manager getAllTasks] objectAtIndex:indexPath.row] taskName ];
    switch ([[[manager getAllTasks] objectAtIndex:indexPath.row] priorty]) {
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
    switch ([[[manager getAllTasks] objectAtIndex:indexPath.row] prog]) {
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    addOrEdit.isEdit = YES;
    addOrEdit.editTask = [[manager getAllTasks] objectAtIndex:indexPath.row];
    addOrEdit.index = (int) indexPath.row;
    [self.navigationController pushViewController:addOrEdit animated:YES];
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
    if(searchText.length==0)
    {
        isFiltered=NO;
    }
    
    else
    {
        filteredArr = [NSArray new];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskName CONTAINS[cd] %@", searchText];
        //    filteredArr = [[manager getAllTasks] filteredArrayUsingPredicate:predicate];
      
}
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

@end
    
