//
//  DoneVC.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "DoneVC.h"
#import "DoneCell.h"
#import "LocalStore.h"
#import "TasksData.h"

@interface DoneVC ()
{
    NSMutableArray* allTasks;
    NSMutableArray* doneTasks;
    LocalStore* local;
}
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end

@implementation DoneVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated
{
    allTasks = [NSMutableArray arrayWithArray:[local getFromDefault]];
    doneTasks = [NSMutableArray new];
    for (int i=0; i< [allTasks count]; i++)
    {
        if ([[allTasks objectAtIndex:i] prog] == 2) {
            [doneTasks addObject:[allTasks objectAtIndex:i]];
           }
    }
   
    [_doneTable reloadData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [doneTasks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    
    cell.taskNameLbl.text = [[doneTasks objectAtIndex:indexPath.row] taskName ];
      switch ([[doneTasks objectAtIndex:indexPath.row] priorty]) {
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
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
}

@end
