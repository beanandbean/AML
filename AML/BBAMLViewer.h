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

@property (weak, nonatomic) id delegate;
@property (weak, nonatomic) UIView *parent;

@property (strong, nonatomic) UIView *rootView;
@property (strong, nonatomic) BBAMLNodeRoot *root;


- (id)initWithAMLData:(NSData *)filename andDelegate:(id)delegate andParentView:(UIView *)parent;

- (void)view;

- (BBAMLDocumentNode *)getElementById:(NSString *)nodeId;
- (NSArray *)getElementsByPattern:(NSString *)pattern;

@end
