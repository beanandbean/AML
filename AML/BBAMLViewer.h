//
//  BBAMLViewer.h
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAMLViewer : NSObject <NSXMLParserDelegate>

- (id)initWithAMLData:(NSData *)filename andParent:(UIView *)parent;

- (void)view;

@end
