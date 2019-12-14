//
//  AddOrEditDelegate.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TasksData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddOrEditDelegate <NSObject>

-(void) saveTask: (TasksData*) task : (int) index ;

@end

NS_ASSUME_NONNULL_END
