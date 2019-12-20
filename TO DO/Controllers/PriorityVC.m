//
//  PriorityVC.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "PriorityVC.h"
#import "PriorityCell.h"
#import "LocalStore.h"
#import "TasksData.h"
@interface PriorityVC ()
{
    NSMutableArray* allTasks;
    LocalStore* local;
    int count;

}
@end

@implementation PriorityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    local = [LocalStore new];
    count = 0;
}
- (void)viewWillAppear:(BOOL)animated
{
    allTasks = [NSMutableArray arrayWithArray:[local getFromDefault]];
//    for (int i=0; i< [allTasks count]; i++)
//    {
//        if ([[allTasks objectAtIndex:i] priorty ] == 2) {
//        //    [doneTasks addObject:[allTasks objectAtIndex:i]];
//            count ++;
//           }
//    }
   
  //  [_doneTable reloadData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PriorityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"priorityCell" forIndexPath:indexPath];
    
    return cell;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
}

@end
