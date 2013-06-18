//
//  BBAMLOperationPositive.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationAdd.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationAdd

- (int)priority {
    return 10;
}

- (bool)needPrecedingObject {
    return YES;
}

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    if (array.count == 1) {
        return [array objectAtIndex:0];
    } else if (array.count == 2) {
        return [[array objectAtIndex:0] objectAdding:[array objectAtIndex:1]];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
