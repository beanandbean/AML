//
//  BBAMLObjectType.h
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAMLObjectType <NSObject>

- (id)initWithString:(NSString *)string;
- (id)initWithFloat:(float)floatValue;

- (NSString *)stringValue;
- (float)floatValue;

- (id<BBAMLObjectType>)negativeObject;
- (id<BBAMLObjectType>)reciprocalObject;

- (id<BBAMLObjectType>)objectAdding:(id<BBAMLObjectType>)object;
- (id<BBAMLObjectType>)objectMinusing:(id<BBAMLObjectType>)object;
- (id<BBAMLObjectType>)objectMultiplying:(id<BBAMLObjectType>)object;
- (id<BBAMLObjectType>)objectDividing:(id<BBAMLObjectType>)object;

@end
