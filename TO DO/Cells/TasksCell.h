//
//  TableViewCell.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TasksCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priorityLbl;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLbl;


@end

NS_ASSUME_NONNULL_END
