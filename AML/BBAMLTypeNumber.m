//
//  BBAMLTypeNumber.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLTypeNumber.h"

#import "BBAMLTypeNone.h"

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

- (float)floatValue {
    return self.value;
}

- (id<BBAMLObjectType>)negativeObject {
    return [[BBAMLTypeNumber alloc] initWithFloat:- self.value];
}

- (id<BBAMLObjectType>)reciprocalObject {
    if (self.value == 0.0) {
        return [[BBAMLTypeNone alloc] init];
    } else {
        return [[BBAMLTypeNumber alloc] initWithFloat:1 / self.value];
    }
}

- (id<BBAMLObjectType>)objectAdding:(id<BBAMLObjectType>)object {
    if ([object isKindOfClass:[BBAMLTypeNumber class]]) {
        return [[BBAMLTypeNumber alloc] initWithFloat:self.value + [object floatValue]];
    } else {
        return self;
    }
}

- (id<BBAMLObjectType>)objectMinusing:(id<BBAMLObjectType>)object {
    return [self objectAdding:[object negativeObject]];
}

- (id<BBAMLObjectType>)objectMultiplying:(id<BBAMLObjectType>)object {
    if ([object isKindOfClass:[BBAMLTypeNumber class]]) {
        return [[BBAMLTypeNumber alloc] initWithFloat:self.value * [object floatValue]];
    } else {
        return self;
    }    
}

- (id<BBAMLObjectType>)objectDividing:(id<BBAMLObjectType>)object {
    return [self objectMultiplying:[object reciprocalObject]];
}

@end
