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
#import <UserNotifications/UserNotifications.h>

@interface AddOrEditTaskVC ()
{
    TasksData* addTask;
    
    
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
    
    
}
-(void) viewWillAppear:(BOOL)animated
{
    addTask = [TasksData new];
    [_nameTxt becomeFirstResponder];
    if(_isEdit)
    {
        [self deleteCertainNotification];
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
        [self resetData];
        
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
        _indexNum = -1;
        [self saveTask];
    }
}
-(void)saveTask
{
    addTask.taskName = _nameTxt.text;
    addTask.taskDesc = _descTxt.text;
    addTask.taskDate = [[NSDate date] changeToString];
    addTask.priorty =  (int) _prioritySegment.selectedSegmentIndex;
    addTask.prog = (int) _progressSegment.selectedSegmentIndex;
    addTask.reminderDate = [_reminderDatePicker.date changeToString];
    [_delegate saveTask:addTask : _indexNum];
    [self showNotification];
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

-(void) showNotification
{
    if (_isGranted) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                         components:NSCalendarUnitYear +
                                         NSCalendarUnitMonth + NSCalendarUnitDay +
                                         NSCalendarUnitHour + NSCalendarUnitMinute +
                                         NSCalendarUnitSecond fromDate:[_reminderDatePicker date]];
        
        content.title = @"Reminder for task";
        content.subtitle = _nameTxt.text;
        content.body = _descTxt.text;
        content.badge = [NSNumber numberWithInteger:([UIApplication sharedApplication].applicationIconBadgeNumber + 1)];
        
        content.sound = [UNNotificationSound defaultSound];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:_nameTxt.text content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
        
    }
    
}

-(void) deleteCertainNotification
{
    NSArray *arr = [NSArray arrayWithObject:_editTask.taskName];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:arr];
}

@end
