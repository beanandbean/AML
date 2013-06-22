//
//  BBAMLOperationNegative.m
//  AML
//
//  Created by wangsw on 6/22/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationNegative.h"

#import "BBAMLOperationPositive.h"

#import "BBAMLTypeNone.h"

@interface BBAMLOperationNegative ()

@property (nonatomic) int pri;

@end

@implementation BBAMLOperationNegative

@synthesize preceding, objects;

- (id)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
        self.pri = [BBAMLOperationPositive priority];
    }
    return self;
}

- (int)priority {
    return self.pri;
}

- (id<BBAMLObjectType>)operate {
    [BBAMLOperationPositive resetPriority];
    if (self.objects.count == 1) {
        return [[self.objects objectAtIndex:0] negativeObject];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
