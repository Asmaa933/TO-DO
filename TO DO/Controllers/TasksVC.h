//
//  ViewController.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddOrEditDelegate.h"

@interface TasksVC : UIViewController <UITableViewDelegate,UITableViewDataSource,AddOrEditDelegate,UISearchBarDelegate,UITabBarControllerDelegate>


@end

