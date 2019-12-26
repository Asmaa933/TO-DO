//
//  ManageTasks.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "ManageTasks.h"
#import "TasksData.h"
#import "NSDate+DateExt.h"
#import "LocalStore.h"

@implementation ManageTasks
{
    NSMutableArray* taskArr;
    LocalStore* local;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        local = [LocalStore new];
        if ([local getFromDefault])
        {
            taskArr = [NSMutableArray arrayWithArray:[local getFromDefault]];
        }
        else
        {
            taskArr = [NSMutableArray new];
        }
        
    }
    return self;
}
-(void ) addTask : (TasksData*) task
{
    [taskArr addObject:task];
    if ([[[taskArr objectAtIndex:0] taskName ]  isEqual: @""])
    {
        [self deleteTask:0];
    }
    [local saveToDefault:taskArr];
}
-(void) deleteTask : (int) index
{
    [taskArr removeObjectAtIndex:index];

    [local saveToDefault:taskArr];
    
    
    
}
-(NSMutableArray*) getAllTasks
{
    return [local getFromDefault];
}
-(void) editTask : (TasksData*) task :(int) index
{
    [taskArr replaceObjectAtIndex:index withObject:task];
    [local saveToDefault:taskArr];
    
}



@end
