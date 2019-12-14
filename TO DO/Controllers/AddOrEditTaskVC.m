//
//  addTaskVC.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "AddOrEditTaskVC.h"
#import "TasksData.h"
#import "AddOrEditDelegate.h"
#import "NSDate+DateExt.h"
#import "NSString+NSStringExt.h"
#import "ManageTasks.h"


@interface AddOrEditTaskVC ()
{
    TasksData* task;
    ManageTasks* manager ;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *descTxt;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *progressSegment;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;

@end

@implementation AddOrEditTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];

    task = [TasksData new];
    manager = [ManageTasks new];
    
}
-(void) viewWillAppear:(BOOL)animated
{
    if(_isEdit)
    {
        self.navigationItem.title = @"Edit Task";
        _nameTxt.text = _editTask.taskName;
        _descTxt.text = _editTask.taskDesc;
        _prioritySegment.selectedSegmentIndex = _editTask.priorty;
        _progressSegment.selectedSegmentIndex =_editTask.prog;
        _reminderDatePicker.date = [_editTask.reminderDate convertToDate];
        
    }
    else
    {
        self.navigationItem.title = @"Add Task";
        
    }
}
- (IBAction)saveBtnPressed:(UIButton *)sender
{
    if(_isEdit)
    {
        [self showAlert];
        
    }
    else
    {
        _index = -1;
        [self saveTask];
    }
    
    
    
}
-(void)saveTask
{
    task.taskName = _nameTxt.text;
    task.taskDesc = _descTxt.text;
    task.taskDate = [[NSDate date] changeToString];
    task.priorty =  (int) _prioritySegment.selectedSegmentIndex;
    task.prog = (int) _progressSegment.selectedSegmentIndex;
    task.reminderDate = [_reminderDatePicker.date changeToString];
    [_delegate saveTask:task : _index];
    [self resetData];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showAlert
{
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are  you sure you want to save?" preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        
        [self saveTask];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
        
        [alert addAction:action1];
        [alert addAction:action2];
    

        [self presentViewController:alert animated:YES completion:nil];
    }

-(void)resetData
{
    _nameTxt.text = @"";
    _descTxt.text = @"";
    _prioritySegment.selectedSegmentIndex = 0;
    _progressSegment.selectedSegmentIndex = 0;
    _reminderDatePicker.date = [NSDate date];
    _isEdit = NO;
}


@end
