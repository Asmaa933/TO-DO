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

@interface progressVC ()

@end

@implementation progressVC
{
    NSMutableArray* progressTasks;
    TasksData* object;
    NSString* mark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    progressTasks = [NSMutableArray new];
    object = [TasksData new];
    [self fillArray];
    mark = @" ";
     
}
-(void) fillArray
{
    NSMutableArray *data = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Key"]];
    for (int i=0; i<[data count]; i++)
    {
        object = [data objectAtIndex:i];
        if ([object prog] == 1)
        {
            [progressTasks addObject:[data objectAtIndex:i]];
        }
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    cell.markLbl.text = mark;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mark  isEqual: @" "])
    {
        mark = @"✔️";
    }
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
}


@end
