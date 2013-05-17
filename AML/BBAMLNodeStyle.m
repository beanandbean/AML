//
//  BBAMLNodeStyle.m
//  AML
//
//  Created by wangsw on 5/17/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLNodeStyle.h"

#import "BBAMLNodeRoot.h"

@implementation BBAMLNodeStyle

- (UIView *)view {
    if ([self.parent.name isEqualToString:@"aml"]) {
        BBAMLNodeRoot *root = (BBAMLNodeRoot *)self.parent;
        [root reportStyleSheet:self.innerText];
    }
    return nil;
}

@end
