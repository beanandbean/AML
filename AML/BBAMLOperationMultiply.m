//
//  BBAMLOperationMultiple.m
//  AML
//
//  Created by wangsw on 6/17/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationMultiply.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationMultiply

- (int)priority {
    return 20;
}

- (bool)needPrecedingObject {
    return YES;
}

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    if (array.count == 2) {
        return [[array objectAtIndex:0] objectMultiplying:[array objectAtIndex:1]];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
