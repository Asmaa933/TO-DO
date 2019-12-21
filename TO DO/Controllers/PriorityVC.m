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
    NSMutableArray* lowTasks;
    NSMutableArray* medTasks;
    NSMutableArray* highTasks;
    LocalStore* local;
    NSMutableArray* arr;
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UITableView *priorityTable;
@end

@implementation PriorityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    local = [LocalStore new];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    allTasks = [NSMutableArray arrayWithArray:[local getFromDefault]];
    arr = [NSMutableArray arrayWithArray:allTasks];

    lowTasks = [NSMutableArray new];
    medTasks = [NSMutableArray new];
    highTasks = [NSMutableArray new];
    for (int i=0; i< [allTasks count]; i++)
    {
        switch ([[allTasks objectAtIndex:i] prog]) {
            case 0:
                [lowTasks addObject:[allTasks objectAtIndex:i]];
                break;
            case 1:
                [medTasks addObject:[allTasks objectAtIndex:i]];
                break;
            case 2:
                [highTasks addObject:[allTasks objectAtIndex:i]];
                break;
                
                
            default:
                break;
        }
        
    }
    [_priorityTable reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PriorityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"priorityCell" forIndexPath:indexPath];
    
    cell.taskNameLabel.text = [[arr objectAtIndex:indexPath.row] taskName ];
    switch ([[arr objectAtIndex:indexPath.row] prog]) {
        case 0:
            cell.progLabel.text = @"🔜";
            break;
        case 1:
            cell.progLabel.text = @"⏳";
            break;
        case 2:
            cell.progLabel.text = @"✔️";
            break;
        default:
            cell.progLabel.text = @"";
            break;
    }
    
    return cell;
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
}
- (IBAction)changeInSegment:(UISegmentedControl *)sender {
    switch (_prioritySegment.selectedSegmentIndex) {
        case 0:
            arr = allTasks;
            break;
        case 1:
            arr = lowTasks;
            break;
        case 2:
            arr = medTasks;
            break;
        case 3:
            arr = highTasks;
            break;
            
        default:
            break;
    }
    [_priorityTable reloadData];
}

@end
