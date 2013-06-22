//
//  BBAMLOperationPositive.h
//  AML
//
//  Created by wangsw on 6/22/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLOperation.h"

@interface BBAMLOperationPositive : NSObject <BBAMLOperation>

+ (int)priority;
+ (void)resetPriority;

@end
