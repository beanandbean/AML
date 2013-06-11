//
//  BBAMLAnimation.h
//  AML
//
//  Created by wangsw on 6/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLStyleSheetParser.h"

@interface BBAMLAnimation : NSObject

- (id)initWithAnimationStyleSheet:(NSString *)styleSheet andDelegate:(BBAMLStyleSheetParser *)delegate;

- (IBAction)runAnimation:(id)sender;

@end
