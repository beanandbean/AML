//
//  BBAMLOperationBracketEnd.m
//  AML
//
//  Created by wangsw on 6/18/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationBracketEnd.h"

#import "BBAMLOperationBracketBegin.h"

@interface BBAMLOperationBracketEnd ()

@property (nonatomic) bool isAboveBracketBegin;

@end

@implementation BBAMLOperationBracketEnd

@synthesize preceding, objects;

- (id)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
        self.isAboveBracketBegin = YES;
    }
    return self;
}

- (int)priority {
    if ([BBAMLOperationBracketBegin recentlyOperated]) {
        self.isAboveBracketBegin = NO;
    }
    if (self.isAboveBracketBegin) {
        return 0;
    } else {
        return 1000;
    }
}

- (id<BBAMLObjectType>)operate {
    return self.preceding;
}

@end
