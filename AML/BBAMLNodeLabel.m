//
//  BBAMLNodeLabel.m
//  AML
//
//  Created by wangsw on 5/18/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeLabel.h"

@implementation BBAMLNodeLabel

- (void)setTextColor:(UIColor *)color {
    [((UILabel *)self.nodeView) setTextColor:color];
}

- (UIView *)view {
    UILabel *nodeView = [[UILabel alloc] init];
    [nodeView setText:self.innerText];
    [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nodeView = nodeView;
    return self.nodeView;
}

@end
