//
//  BBOperationBracketBegin.m
//  AML
//
//  Created by wangsw on 6/18/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationBracketBegin.h"

static bool recentlyOperated = NO;

@interface BBAMLOperationBracketBegin ()

@property (nonatomic) bool isFirstToAskPriority;

@end

@implementation BBAMLOperationBracketBegin

@synthesize preceding, objects;

+ (bool)recentlyOperated {
    bool answer = recentlyOperated;
    recentlyOperated = NO;
    return answer;
}

- (id)init {
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
        self.isFirstToAskPriority = YES;
    }
    return self;
}

- (int)priority {
    if (self.isFirstToAskPriority) {
        self.isFirstToAskPriority = NO;
        return 1000;
    } else {
        return 0;
    }
}

- (id<BBAMLObjectType>)operate {
    recentlyOperated = YES;
    return [self.objects objectAtIndex:0];
}

@end
