//
//  BBAMLNodeMain.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeMain.h"

@implementation BBAMLNodeMain

- (UIView *)view {
    [super view];
    [self fullScreenWithPriority:1000];
    return self.nodeView;
}

@end
