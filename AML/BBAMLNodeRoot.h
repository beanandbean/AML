//
//  BBAMLNodeAml.h
//  AML
//
//  Created by wangsw on 5/11/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLDocumentNode.h"

#import "BBAMLViewer.h"

@interface BBAMLNodeRoot : BBAMLDocumentNode

@property (weak, nonatomic) BBAMLViewer *viewer;
@property (strong, nonatomic) NSMutableString *styleSheet;

- (void)reportStyleSheet:(NSString *)styleSheet;

@end
