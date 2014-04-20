//
//  TodoItem.m
//  TodoList
//
//  Created by Prashanth Govindaraj on 4/20/14.
//  Copyright (c) 2014 Prashanth Govindaraj. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

- (id)initWithText:(NSString*)text
{
    if (self = [super init])
        self.text = text;
    return self;
}

+ (id)toDoItemWithText:(NSString *)text
{
    return [[TodoItem alloc] initWithText:text];
}

@end
