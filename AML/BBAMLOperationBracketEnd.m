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

- (id)init {
    self = [super init];
    if (self) {
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

- (bool)needPrecedingObject {
    return YES;
}

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    return [array objectAtIndex:0];
}

@end
