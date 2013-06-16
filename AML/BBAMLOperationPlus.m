//
//  BBAMLOperationPositive.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationPlus.h"

#import "BBAMLTypeNumber.h"
#import "BBAMLTypeNone.h"

@implementation BBAMLOperationPlus

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    if (array.count == 1) {
        return [array objectAtIndex:0];
    } else if (array.count == 2) {
        if ([[array objectAtIndex:0] class] == [BBAMLTypeNumber class]) {
            if ([[array objectAtIndex:1] class] == [BBAMLTypeNumber class]) {
                BBAMLTypeNumber *first = [array objectAtIndex:0];
                BBAMLTypeNumber *second = [array objectAtIndex:1];
                return [[BBAMLTypeNumber alloc] initWithFloat:first.value + second.value];
            } else {
                return [array objectAtIndex:0];
            }
        } else {
            return [array objectAtIndex:1];
        }
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
