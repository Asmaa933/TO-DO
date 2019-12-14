//
//  DetailsVC.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "DetailsVC.h"
#import "TasksData.h"
@interface DetailsVC ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastEditLabel;
@property (weak, nonatomic) IBOutlet UILabel *reminderDateLabel;

@end

@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Detail of task";
}
- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];

}
-(void) updateUI
{
    _nameLabel.text = _detailTask.taskName;
    _descLabel.text = _detailTask.taskDesc;
    _lastEditLabel.text = _detailTask.taskDate;
    _reminderDateLabel.text = _detailTask.reminderDate;
    switch (_detailTask.priorty)
    {
        case 0:
            _priorityLabel.text = @"Low";
            break;
        case 1:
            _priorityLabel.text = @"Medium";
            
            break;
        case 2:
            _priorityLabel.text = @"High";
            
            break;
        default:
            break;
    }
    switch (_detailTask.prog) {
        case 0:
            _progressLabel.text = @"To Do";
            break;
        case 1:
            _progressLabel.text = @"In Progress";
            
            break;
        case 2:
            _progressLabel.text = @"Done";
            
            break;
        default:
            break;
    }
}

@end
