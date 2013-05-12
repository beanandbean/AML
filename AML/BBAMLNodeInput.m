//
//  BBAMLNodeLabel.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeInput.h"

@implementation BBAMLNodeInput

- (UIView *)view {
    UITextField *nodeView = [[UITextField alloc] init];
    nodeView.placeholder = self.innerText;
    nodeView.borderStyle = UITextBorderStyleRoundedRect;
    [nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.nodeView = nodeView;
    return self.nodeView;
}

@end
