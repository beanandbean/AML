//
//  BBAMLTypeNumber.h
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLObjectType.h"

@interface BBAMLTypeNumber : NSObject <BBAMLObjectType>

@property (nonatomic) float value;

- (id)initWithFloat:(float)floatValue;

@end
