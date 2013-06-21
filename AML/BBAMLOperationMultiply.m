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
        return [self.preceding objectMultiplying:[self.objects objectAtIndex:0]];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
