//
//  BBAMLNodeView.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeView.h"

#import "BBAMLNodeRoot.h"

@implementation BBAMLNodeView

- (UIView *)view {
    [super view];
    if ([self.parent.name isEqualToString:@"aml"]) {
        [self fullScreenWithPriority:500];
    }
    for (BBAMLDocumentNode *node in self.children) {
        UIView *childView = [node view];
        if (childView) {
            [self.nodeView addSubview:childView];
        }
    }
    return self.nodeView;
}

- (void)fullScreenWithPriority:(int)priority {
    UIView *superView = ((BBAMLNodeRoot *)self.parent).viewer.parent;
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.nodeView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:superView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0.0];
    leftConstraint.priority = priority;
    [superView addConstraint:leftConstraint];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.nodeView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:superView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:0.0];
    rightConstraint.priority = priority;
    [superView addConstraint:rightConstraint];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.nodeView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:superView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
    topConstraint.priority = priority;
    [superView addConstraint:topConstraint];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.nodeView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:superView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:0.0];
    bottomConstraint.priority = priority;
    [superView addConstraint:bottomConstraint];

}

@end
