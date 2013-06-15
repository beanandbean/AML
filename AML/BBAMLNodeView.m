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
    for (BBAMLDocumentNode *node in self.children) {
        UIView *childView = [node view];
        if (childView) {
            [self.nodeView addSubview:childView];
        }
    }
    return self.nodeView;
}

@end
