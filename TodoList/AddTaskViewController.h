//
//  AddTaskViewController.h
//  TodoList
//
//  Created by Prashanth Govindaraj on 4/22/14.
//  Copyright (c) 2014 Prashanth Govindaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtFldDueDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFldTask;

@end
