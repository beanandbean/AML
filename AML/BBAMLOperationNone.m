//
//  BBAMLOperationNone.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationNone.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationNone

@synthesize preceding, objects;

- (id)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
    }
    return self;
}

- (int)priority {
    return -1000;
}

- (id<BBAMLObjectType>)operate {
    return [[BBAMLTypeNone alloc] init];
}

@end
