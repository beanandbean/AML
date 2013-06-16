//
//  BBAMLOperationNone.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationNone.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationNone

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    return [[BBAMLTypeNone alloc] init];
}

@end
