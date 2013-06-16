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

- (NSString *)stringValue;

@end
