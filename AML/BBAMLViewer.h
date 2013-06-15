//
//  BBAMLViewer.h
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAMLDocumentNode.h"

@class BBAMLNodeRoot;

@interface BBAMLViewer : NSObject <NSXMLParserDelegate>

- (id)initWithAMLData:(NSData *)filename andDelegate:(id)delegate andParentView:(UIView *)parent;

- (void)view;
- (void)removeView;

- (BBAMLDocumentNode *)getElementById:(NSString *)nodeId;
- (NSArray *)getElementsByPattern:(NSString *)pattern;

@end
