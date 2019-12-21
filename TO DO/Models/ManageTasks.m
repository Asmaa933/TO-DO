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
            TasksData* t1 = [TasksData new];
            t1.priorty = 4;
            t1.prog = 4;
            t1.reminderDate = [[NSDate date]changeToString];
            t1.taskDate = [[NSDate date]changeToString];
            t1.taskName = @"";
            t1.taskDesc = @"";
            taskArr =  [[NSMutableArray alloc] initWithObjects:t1, nil];
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
    if (![taskArr count]) {
        TasksData* t1 = [TasksData new];
        t1.priorty = 4;
        t1.prog = 4;
        t1.reminderDate = [[NSDate date]changeToString];
        t1.taskDate = [[NSDate date]changeToString];
        t1.taskName = @"";
        t1.taskDesc = @"";
        taskArr =  [[NSMutableArray alloc] initWithObjects:t1, nil];
    }
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
