//
//  ManageTasks.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TasksData.h"
NS_ASSUME_NONNULL_BEGIN

@interface ManageTasks : NSObject

-(void ) addTask : (TasksData*) task;
-(void) deleteTask : (int) index;
-(NSMutableArray*) getAllTasks;
-(void) editTask : (TasksData*) task :(int) index;
@end

NS_ASSUME_NONNULL_END
