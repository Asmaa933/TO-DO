//
//  TasksData.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "TasksData.h"

@implementation TasksData
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
        self.taskName = [decoder decodeObjectForKey:@"taskName"];
        self.taskDesc = [decoder decodeObjectForKey:@"taskDesc"];
        self.taskDate = [decoder decodeObjectForKey:@"taskDate"];
        self.reminderDate = [decoder decodeObjectForKey:@"reminderDate"];
        self.priorty = [decoder decodeBoolForKey:@"priorty"];
        self.prog = [decoder decodeBoolForKey:@"prog"];
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.taskName forKey:@"taskName"];
    [encoder encodeObject:self.taskDesc forKey:@"taskDesc"];
    [encoder encodeBool:self.taskDate forKey:@"taskDate"];
    [encoder encodeBool:self.reminderDate forKey:@"reminderDate"];
    [encoder encodeBool:self.priorty forKey:@"priorty"];
    [encoder encodeBool:self.prog forKey:@"prog"];
}
@end
