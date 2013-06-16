//
//  BBAMLCalculator.h
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLObjectType.h"

@interface BBAMLCalculator : NSObject

+ (id<BBAMLObjectType>)calculateExpression:(NSString *)expression;

@end
