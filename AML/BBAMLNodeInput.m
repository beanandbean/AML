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

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [(UITextField *)self.nodeView addTarget:target action:action forControlEvents:controlEvents];
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
