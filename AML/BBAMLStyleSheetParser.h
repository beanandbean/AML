//
//  BBAMLStyleSheetParser.h
//  AML
//
//  Created by wangsw on 5/12/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLViewer.h"

@interface BBAMLStyleSheetParser : NSObject

- (id)initWithAMLViewer:(BBAMLViewer *)viewer;

- (void)parse;

@end
