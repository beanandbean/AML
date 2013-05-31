//
//  BBAMLNodeLabel.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeInput.h"

@implementation BBAMLNodeInput

- (void)setTextColor:(UIColor *)color {
    [((UITextField *)self.nodeView) setTextColor:color];
}

- (UIView *)view {
    UITextField *nodeView = [[UITextField alloc] init];
    [nodeView setText:self.innerText];
    [nodeView setBackgroundColor:[UIColor whiteColor]];
    [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nodeView = nodeView;
    return self.nodeView;
}

@end
