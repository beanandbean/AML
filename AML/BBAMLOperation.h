//
//  BBAMLOperation.h
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLObjectType.h"

@protocol BBAMLOperation <NSObject>

@property (strong, nonatomic) id<BBAMLObjectType> preceding;
@property (strong, nonatomic) NSMutableArray *objects;

- (int)priority;

- (id<BBAMLObjectType>)operate;

@end
