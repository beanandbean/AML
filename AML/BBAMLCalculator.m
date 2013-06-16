//
//  BBAMLCalculator.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLCalculator.h"

#import "BBAMLOperation.h"

#import "BBAMLTypeNumber.h"

#import "BBAMLOperationNone.h"
#import "BBAMLOperationPlus.h"

@implementation BBAMLCalculator

+ (id<BBAMLObjectType>)calculateExpression:(NSString *)expression {
    NSMutableArray *operations = [NSMutableArray arrayWithObject:[[BBAMLOperationNone alloc] init]];
    NSMutableArray *objects = [NSMutableArray arrayWithObject:[[NSMutableArray alloc] init]];
    NSMutableString *buffer;
    expression = [expression stringByAppendingString:@" "];
    for (int index = 0; index < expression.length; index++) {
        char character = [expression characterAtIndex:index];
        if ((character >= '0' && character <= '9') || character == '.') {
            if (buffer) {
                [buffer appendFormat:@"%c", character];
            } else {
                buffer = [NSMutableString stringWithFormat:@"%c", character];
            }
        } else {
            if (buffer) {
                [objects.lastObject addObject:[[BBAMLTypeNumber alloc] initWithString:buffer]];
                buffer = nil;
                if ([operations.lastObject class] != [BBAMLOperationNone class]) {
                    [objects replaceObjectAtIndex:objects.count - 1 withObject:[NSMutableArray arrayWithObject:[(id<BBAMLOperation>)operations.lastObject operateWithArray:objects.lastObject]]];
                    [operations replaceObjectAtIndex:operations.count - 1 withObject:[[BBAMLOperationNone alloc] init]];
                }
            }
            if (character == '+') {
                [operations addObject:[[BBAMLOperationPlus alloc] init]];
            }
        }
    }
    return [objects.lastObject objectAtIndex:0];
}

@end
