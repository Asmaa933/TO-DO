//
//  DoneCell.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priorityLbl;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLbl;

@end

NS_ASSUME_NONNULL_END
