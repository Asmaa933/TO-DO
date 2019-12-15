//
//  addTaskVC.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddOrEditDelegate.h"
#import "TasksData.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddOrEditTaskVC : UIViewController 
@property BOOL isEdit;
@property id <AddOrEditDelegate> delegate;
@property TasksData* editTask;
@property int indexNum;
@end

NS_ASSUME_NONNULL_END

