//
//  RootViewController.m
//  TodoList
//
//  Created by Prashanth Govindaraj on 4/20/14.
//  Copyright (c) 2014 Prashanth Govindaraj. All rights reserved.
//

#import "RootViewController.h"
#import "TodoItem.h"
#import "AddTaskViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
- (void)prepareDataSource;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self prepareDataSource];
        self.navigationItem.title = @"Tasks";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addNewTask:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - Add Task

- (void)addNewTask:(id)sender
{
    AddTaskViewController *detailViewController = [[AddTaskViewController alloc] initWithNibName:@"AddTaskViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark - Populate data source

- (void)prepareDataSource
{
    _dataSourceArray = [[NSMutableArray alloc] init];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Feed the dog"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Buy milk"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Pack bags for WWDC"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Rule the web"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Buy a new iPhone"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Do your laundry"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Write a new tutorial"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Master Objective-C"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Drink less beer"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Learn to draw"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Take the car to the garage"]];
    [_dataSourceArray addObject:[TodoItem toDoItemWithText:@"Learn to juggle"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSourceArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *myIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier forIndexPath:indexPath];
    
    TodoItem *item = [_dataSourceArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.showsReorderControl = YES;

    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_dataSourceArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
