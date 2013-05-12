//
//  BBAMLNodeView.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeView.h"

#import "BBAMLNodeRoot.h"

@interface BBAMLNodeView ()

@property (weak, nonatomic) UIView *superView;

@end

@implementation BBAMLNodeView

- (UIView *)view {
    [super view];
    if ([self.parent.name isEqualToString:@"aml"]) {
        self.superView = ((BBAMLNodeRoot *)self.parent).viewer.parent;
        [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.nodeView
                                                                   attribute:NSLayoutAttributeLeft
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superView
                                                                   attribute:NSLayoutAttributeLeft
                                                                  multiplier:1.0
                                                                    constant:0.0]];
        [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.nodeView
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:0.0]];
        [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.nodeView
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superView
                                                                   attribute:NSLayoutAttributeTop
                                                                  multiplier:1.0
                                                                    constant:0.0]];
        [self.superView addConstraint:[NSLayoutConstraint constraintWithItem:self.nodeView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.superView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:0.0]];
    }
    for (BBAMLDocumentNode *node in self.children) {
        UIView *childView = [node view];
        if (childView) {
            [self.nodeView addSubview:childView];
        }
    }
    return self.nodeView;
}

@end
