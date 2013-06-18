//
//  BBAMLOperationMinus.m
//  AML
//
//  Created by wangsw on 6/17/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationMinus.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationMinus

- (int)priority {
    return 10;
}

- (bool)needPrecedingObject {
    return YES;
}

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    if (array.count == 1) {
        return [[array objectAtIndex:0] negativeObject];
    } else if (array.count == 2) {
        return [[array objectAtIndex:0] objectMinusing:[array objectAtIndex:1]];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
