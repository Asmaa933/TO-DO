//
//  TasksData.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TasksData : NSObject <NSCoding>
  @property NSString* taskName;
  @property NSString* taskDesc;
  @property NSString* taskDate;
  @property NSString* reminderDate;
  @property int priorty;
  @property int prog;
    


@end

NS_ASSUME_NONNULL_END
