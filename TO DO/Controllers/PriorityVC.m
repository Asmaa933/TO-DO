//
//  PriorityVC.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "PriorityVC.h"
#import "PriorityCell.h"

@interface PriorityVC ()

@end

@implementation PriorityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
