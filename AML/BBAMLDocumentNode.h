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

@property (strong, nonatomic) UIView *nodeView;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *innerText;
@property (strong, nonatomic) NSDictionary *attributes;
@property (strong, nonatomic) NSMutableArray *children;

- (id)initWithElementName:(NSString *)name attributes:(NSDictionary *)attributeDict andParent:(BBAMLDocumentNode *)parent;

- (BBAMLDocumentNode *)addChildWithName:(NSString *)name andAttributes:(NSDictionary *)attributeDict;

- (UIView *)view;

- (BBAMLDocumentNode *)getElementById:(NSString *)nodeId;

- (void)log;
- (void)logTree;

@end
