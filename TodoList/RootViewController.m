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
@property (nonatomic, strong) NSMutableDictionary *dataSource;

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
    [self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - Populate data source

- (void)prepareDataSource
{    
    NSArray *objectsArray = @[@[@"Feed the dog", @"Buy milk", @"Pack bags for WWDC"],
                              @[@"Rule the web" , @"Buy a new iPhone"],
                              @[@"Do your laundry" , @"Write a new tutorial"],
                              @[@"Master Objective-C" , @"Drink less beer", @"Drink more water"],
                              @[@"Learn to draw" , @"Get a hair cut"]];
    NSArray *keysArray = @[[self generateRandomDate],
                           [self generateRandomDate],
                           [self generateRandomDate],
                           [self generateRandomDate],
                           [self generateRandomDate]];
    _dataSource = [NSMutableDictionary dictionaryWithObjects:objectsArray forKeys:keysArray];
}

//- (void)sortDataSource
//{
//    
//    NSArray *keys = [_dataSource allKeys];
//    NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
//    NSMutableDictionary *sortedDictionary = [[NSMutableDictionary alloc] init];
//    for (NSDate * key in sortedKeys)
//    {
//        [sortedDictionary setObject:[_dataSource objectForKey:key] forKey:key];
//        //sortedDictionary = (NSMutableDictionary*) @{[_dataSource objectForKey:key]: key};
//    }
//    NSLog(@"%@",sortedDictionary);
//    
//    /*
//    NSSortDescriptor* sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
//    [_dataSourceArray sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
//    _headerArray = [[NSMutableArray alloc]initWithCapacity:0];
//    
//    for (TodoItem *item in _dataSourceArray){
//        NSString *dateString = [self convertDateToString:item.date];
//        if (![_headerArray isEqual:dateString]){
//            [_headerArray addObject:dateString];
//        }
//    }*/
//}

- (NSArray*)getObjectAtIndex:(NSInteger)index
{
    NSArray *keys = [_dataSource allKeys];
    id aKey = [keys objectAtIndex:index];
    return [_dataSource objectForKey:aKey];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_dataSource allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getObjectAtIndex:section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)];
    label.text = [self convertDateToString:[[_dataSource allKeys] objectAtIndex:section]];;
    label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *myIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text =  [[self getObjectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
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
        NSMutableArray *array = [[self getObjectAtIndex:indexPath.section] mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        [_dataSource setObject:(NSArray*)array forKey:[[_dataSource allKeys]objectAtIndex:indexPath.section]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray *fromArray = [[self getObjectAtIndex:fromIndexPath.section] mutableCopy];
    NSMutableArray *toArray = [[self getObjectAtIndex:toIndexPath.section] mutableCopy];
    if (fromIndexPath.section != toIndexPath.section) {
        [toArray insertObject:[fromArray objectAtIndex:fromIndexPath.row] atIndex:toIndexPath.row];
        [fromArray removeObject:[fromArray objectAtIndex:fromIndexPath.row]];
        
        [_dataSource setObject:(NSArray*)fromArray forKey:[[_dataSource allKeys]objectAtIndex:fromIndexPath.section]];
        [_dataSource setObject:(NSArray*)toArray forKey:[[_dataSource allKeys]objectAtIndex:toIndexPath.section]];
    }
    else{
        [fromArray exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
        [_dataSource setObject:(NSArray*)fromArray forKey:[[_dataSource allKeys]objectAtIndex:fromIndexPath.section]];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Random date

- (NSDate *)generateRandomDate
{
    int r1 = arc4random_uniform(60) + 1;
    int r2 = arc4random_uniform(23);
    int r3 = arc4random_uniform(59);
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian =
    [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *offsetComponents = [NSDateComponents new];
    [offsetComponents setDay:(r1*-1)];
    [offsetComponents setHour:r2];
    [offsetComponents setMinute:r3];
    
    NSDate *rndDate1 = [gregorian dateByAddingComponents:offsetComponents
                                                  toDate:today options:0];
    
    return rndDate1;
}

- (NSString*)convertDateToString:(NSDate*)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/YYYY"];
    
    return [df stringFromDate:date];
}

#pragma mark -
#pragma mark - Save Data

- (void)saveData
{
    
}


@end
