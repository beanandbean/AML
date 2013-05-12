//
//  BBAMLNodeButton.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeButton.h"

@implementation BBAMLNodeButton

- (UIView *)view {
    UIButton *nodeView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nodeView setTitle:self.innerText forState:UIControlStateNormal];
    [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nodeView = nodeView;
    return self.nodeView;
}

@end
