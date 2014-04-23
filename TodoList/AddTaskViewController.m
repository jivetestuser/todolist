//
//  AddTaskViewController.m
//  TodoList
//
//  Created by Prashanth Govindaraj on 4/22/14.
//  Copyright (c) 2014 Prashanth Govindaraj. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()
@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation AddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addToolbar];
        [self setupDatePicker];
        [_txtFldDueDate setText: [self convertDateToString:[NSDate date]]];
        [_txtFldDueDate becomeFirstResponder];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    CGRect toolBarRect = self.view.frame;
    toolBarRect.size.height = 64.0f;
    _toolbar.frame = toolBarRect;
}

- (void)addToolbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [_toolbar setTranslucent:YES];
    [self.view addSubview:_toolbar];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                 target:self
                                                                                 action:@selector(cancelTapped:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:self
                                                                           action:nil];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(saveTapped:)];
    
    _toolbar.items = [NSArray arrayWithObjects:cancelButton,spacer,saveButton, nil];
}

- (void)setupDatePicker
{
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:)
          forControlEvents:UIControlEventValueChanged];
    _txtFldDueDate.inputView = _datePicker;
}

#pragma mark - Date Picker

- (void)datePickerValueChanged:(id)sender
{
    [_txtFldDueDate setText:[self convertDateToString: _datePicker.date]];
}

- (NSString*)convertDateToString:(NSDate*)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/YYYY"];
    
    return [df stringFromDate:date];
}

#pragma mark - Cancel and Save

- (void)cancelTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Textfield delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}


@end
