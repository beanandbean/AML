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

+ (bool)recentlyOperated {
    bool answer = recentlyOperated;
    recentlyOperated = NO;
    return answer;
}

- (id)init {
    self = [super init];
    if (self) {
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

- (bool)needPrecedingObject {
    return NO;
}

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    recentlyOperated = YES;
    return [array objectAtIndex:0];
}

@end
