//
//  BBAMLTypeNumber.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLTypeNumber.h"

@implementation BBAMLTypeNumber

- (id)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        self.value = [string floatValue];
    }
    return self;
}

- (id)initWithFloat:(float)floatValue {
    self = [super init];
    if (self) {
        self.value = floatValue;
    }
    return self;
}

- (NSString *)stringValue {
    return [NSString stringWithFormat:@"%f", self.value];
}

@end
