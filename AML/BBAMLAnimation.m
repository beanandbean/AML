//
//  BBAMLAnimation.m
//  AML
//
//  Created by wangsw on 6/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLAnimation.h"

@interface BBAMLAnimation ()

@property (nonatomic) float duration;

@property (weak, nonatomic) BBAMLStyleSheetParser *delegate;

@property (strong, nonatomic) NSString *styleSheet;

@end

@implementation BBAMLAnimation

- (id)initWithAnimationStyleSheet:(NSString *)styleSheet duration:(float)duration andDelegate:(BBAMLStyleSheetParser *)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.duration = duration;
        self.styleSheet = styleSheet;
    }
    return self;
}

- (void)runAnimation:(id)sender {
    [UIView animateWithDuration:self.duration animations:^{
        [self.delegate parseStyleSheet:self.styleSheet];
    }];
}

@end
