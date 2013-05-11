//
//  BBAMLDocumentNode.h
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAMLDocumentNode : NSObject

@property (weak, nonatomic) BBAMLDocumentNode *parent;

@property (strong, nonatomic) NSString *innerText;

- (id)initWithElementName:(NSString *)name andParent:(BBAMLDocumentNode *)parent;

- (BBAMLDocumentNode *)addChildWithName:(NSString *)name;

- (void)log;
- (void)logTree;

@end
