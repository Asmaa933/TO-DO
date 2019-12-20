//
//  TasksData.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "TasksData.h"

@implementation TasksData
- (id)initWithCoder:(NSCoder *) decoder {
    if (self = [super init]) {
        
        self.taskName = [decoder decodeObjectForKey:@"taskName"];
        self.taskDesc = [decoder decodeObjectForKey:@"taskDesc"];
        self.taskDate = [decoder decodeObjectForKey:@"taskDate"];
        self.reminderDate = [decoder decodeObjectForKey:@"reminderDate"];
        self.priorty = [decoder decodeIntForKey:@"priorty"];
        self.prog = [decoder decodeIntForKey:@"prog"];

    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject: self.taskName forKey:@"taskName"];
    [encoder encodeObject: self.taskDesc forKey:@"taskDesc"];
    [encoder encodeObject: self.taskDate forKey:@"taskDate"];
    [encoder encodeObject: self.reminderDate forKey:@"reminderDate"];
    [encoder encodeInt: self.priorty forKey:@"priorty"];
    [encoder encodeInt: self.prog forKey:@"prog"];
}
          
    
@end
