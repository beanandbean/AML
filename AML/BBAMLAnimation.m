//
//  BBAMLAnimation.m
//  AML
//
//  Created by wangsw on 6/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLAnimation.h"

@interface BBAMLAnimation ()

@property (weak, nonatomic) BBAMLStyleSheetParser *delegate;

@property (strong, nonatomic) NSString *styleSheet;

@end

@implementation BBAMLAnimation

- (id)initWithAnimationStyleSheet:(NSString *)styleSheet andDelegate:(BBAMLStyleSheetParser *)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.styleSheet = styleSheet;
    }
    return self;
}

- (void)runAnimation:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
        [self.delegate parseStyleSheet:self.styleSheet];
    }];
}

@end
