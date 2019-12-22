//
//  progressVC.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "progressVC.h"
#import "progressCell.h"
#import "TasksData.h"
#import "LocalStore.h"
#import "TasksData.h"
#import "ManageTasks.h"

@interface progressVC ()
{
    NSMutableArray* allTasks;
    NSMutableArray* progressTasks;
    LocalStore* local;
    ManageTasks* manage;
}
@property (weak, nonatomic) IBOutlet UITableView *progressTable;
@property (weak, nonatomic) IBOutlet UILabel *taskVCLabel;

@end

@implementation progressVC
- (void)viewDidLoad {
    [super viewDidLoad];
    local = [LocalStore new];
}
- (void)viewWillAppear:(BOOL)animated

{
    allTasks = [NSMutableArray arrayWithArray:[local getFromDefault]];
    progressTasks = [NSMutableArray new];
    
    for (int i=0; i< [allTasks count]; i++)
    {
        if ([[allTasks objectAtIndex:i] prog] == 1) {
            [progressTasks addObject:[allTasks objectAtIndex:i]];
        }
    }
    
    
    [_progressTable reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![progressTasks count]) {
        _taskVCLabel.text = @"No in progress tasks";
        
    }
    else{
        _taskVCLabel.text = @"Press on task to mark as complete";
    }
    return [progressTasks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    progressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"progressCell" forIndexPath:indexPath];
    cell.taskNameLbl.text = [[progressTasks objectAtIndex:indexPath.row] taskName];
    switch ([[progressTasks objectAtIndex:indexPath.row] priorty])
    {
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showChangeStatusAlert:(int) indexPath.row];

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"In progress Tasks";
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
}

-(void) showChangeStatusAlert: (int) index
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are  you sure you want to mark task as completed?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
        
        [self changeStatus:index];

    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) changeStatus :(int) index
{
    manage = [ManageTasks new];
    int selIndex = 0;
    TasksData* selectedTask = [progressTasks objectAtIndex:index];
    for (int i = 0 ; i < [allTasks count];i++)
    {
        if ([selectedTask taskName] == [[allTasks objectAtIndex:i] taskName])
        {
            selIndex = i;
            break;
        }
    }
    [progressTasks removeObjectAtIndex:index];
    selectedTask.prog = 2;
    
    [manage editTask:selectedTask :selIndex];
    [_progressTable reloadData];
}

@end
