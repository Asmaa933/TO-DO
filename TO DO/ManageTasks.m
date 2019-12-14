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
@implementation ManageTasks
{
NSMutableArray* taskArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
            TasksData* t1 = [TasksData new];
            t1.priorty = 4;
            t1.prog = 4;
            t1.reminderDate = [[NSDate date]changeToString];
            t1.taskDate = [[NSDate date]changeToString];
            t1.taskName = @"";
            t1.taskDesc = @"";
        taskArr =  [[NSMutableArray alloc] initWithObjects:t1, nil];
           
    }
    return self;
}
-(void ) addTask : (TasksData*) task
{
    if ([[[taskArr objectAtIndex:0] taskName ]  isEqual: @""])
    {
        [self deleteTask:0];
    }
    [taskArr addObject:task];
}
-(void) deleteTask : (int) index
{
    [taskArr removeObjectAtIndex:index];
}
-(NSMutableArray*) getAllTasks
{
    return taskArr;
}
-(void) editTask : (TasksData*) task :(int) index
{

    [taskArr replaceObjectAtIndex:index withObject:task];
}



@end
