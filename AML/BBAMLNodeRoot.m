//
//  BBAMLNodeAml.m
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeRoot.h"

@implementation BBAMLNodeRoot

- (UIView *)view {
    if ([self.name isEqualToString:@"aml"]) {
        for (BBAMLDocumentNode *node in self.children) {
            UIView *childView = [node view];
            if ([node.name isEqualToString:@"main"]) {
                self.nodeView = childView;
            }
        }
    }
    return self.nodeView;
}

- (void)reportStyleSheet:(NSString *)styleSheet {
    if (self.styleSheet) {
        [self.styleSheet appendString:styleSheet];
    } else {
        self.styleSheet = [styleSheet mutableCopy];
    }
}

@end
