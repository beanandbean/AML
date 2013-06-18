//
//  BBAMLTypeNone.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLTypeNone.h"

@implementation BBAMLTypeNone

- (id)initWithString:(NSString *)string {
    self = [super init];
    return self;
}

- (id)initWithFloat:(float)floatValue {
    self = [super init];
    return self;
}

- (NSString *)stringValue {
    return @"";
}

- (float)floatValue {
    return 0.0;
}

- (id<BBAMLObjectType>)negativeObject {
    return self;
}

- (id<BBAMLObjectType>)reciprocalObject {
    return self;
}

- (id<BBAMLObjectType>)objectAdding:(id<BBAMLObjectType>)object {
    return object;
}

- (id<BBAMLObjectType>)objectMinusing:(id<BBAMLObjectType>)object {
    return [object negativeObject];
}

- (id<BBAMLObjectType>)objectMultiplying:(id<BBAMLObjectType>)object {
    return object;
}

- (id<BBAMLObjectType>)objectDividing:(id<BBAMLObjectType>)object {
    return [object reciprocalObject];
}

@end
