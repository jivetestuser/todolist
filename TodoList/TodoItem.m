//
//  TodoItem.m
//  TodoList
//
//  Created by Prashanth Govindaraj on 4/20/14.
//  Copyright (c) 2014 Prashanth Govindaraj. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

- (id)initWithText:(NSString*)text dueDate:(NSDate*)dueDate
{
    if (self = [super init]){
        self.text = text;
        self.date = dueDate;
    }
    return self;
}

+ (id)toDoItemWithText:(NSString *)text dueDate:(NSDate*)dueDate
{
    return [[TodoItem alloc] initWithText:text dueDate:dueDate];
}

@end
