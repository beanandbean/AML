//
//  BBAMLOperationPositive.m
//  AML
//
//  Created by wangsw on 6/22/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationPositive.h"

#import "BBAMLTypeNone.h"

static int priority = 30;

@interface BBAMLOperationPositive ()

@property (nonatomic) int pri;

@end

@implementation BBAMLOperationPositive

@synthesize preceding, objects;

+ (int)priority {
    int currentPriority = priority;
    priority++;
    return currentPriority;
}

+ (void)resetPriority {
    priority = 30;
}

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
        return [self.objects objectAtIndex:0];
    } else {
        return [[BBAMLTypeNone alloc] init];
    }
}

@end
