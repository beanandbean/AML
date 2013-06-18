//
//  BBAMLOperationEnd.m
//  AML
//
//  Created by wangsw on 6/18/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLOperationEnd.h"

#import "BBAMLTypeNone.h"

@implementation BBAMLOperationEnd

- (int)priority {
    return -100;
}

- (bool)needPrecedingObject {
    return NO;
}

- (id<BBAMLObjectType>)operateWithArray:(NSArray *)array {
    return [[BBAMLTypeNone alloc] init];
}

@end
