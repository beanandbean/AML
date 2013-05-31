//
//  BBAMLNodeButton.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeButton.h"

@implementation BBAMLNodeButton

- (void)setTextColor:(UIColor *)color {
    [((UIButton *)self.nodeView) setTitleColor:color forState:UIControlStateNormal];
}

- (UIView *)view {
    UIButton *nodeView = [UIButton buttonWithType:UIButtonTypeCustom];
    [nodeView setTitle:self.innerText forState:UIControlStateNormal];
    [nodeView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nodeView setBackgroundColor:[UIColor whiteColor]];
    [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nodeView = nodeView;
    return self.nodeView;
}

@end
