//
//  BBAMLOperationEnd.m
//  AML
//
//  Created by wangsw on 6/18/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationEnd.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationEnd

@synthesize preceding, objects;

- (id)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
    }
    return self;
}

- (int)priority {
    return -100;
}

- (id<BBAMLObjectType>)operate {
    return [[BBAMLTypeNone alloc] init];
}

@end
