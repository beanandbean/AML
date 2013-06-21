//
//  BBAMLOperationDivide.m
//  AML
//
//  Created by wangsw on 6/17/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationDivide.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationDivide

@synthesize preceding, objects;

- (id)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
    }
    return self;
}

- (int)priority {
    return 20;
}

- (id<BBAMLObjectType>)operate {
    if (self.objects.count == 1 && self.preceding) {
        return [self.preceding objectDividing:[self.objects objectAtIndex:0]];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
