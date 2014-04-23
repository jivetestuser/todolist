//
//  TodoItem.h
//  TodoList
//
//  Created by Prashanth Govindaraj on 4/20/14.
//  Copyright (c) 2014 Prashanth Govindaraj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, assign) BOOL completed;

+ (id)toDoItemWithText:(NSString *)text dueDate:(NSDate*)dueDate;
- (id)initWithText:(NSString*)text dueDate:(NSDate*)dueDate;

@end
