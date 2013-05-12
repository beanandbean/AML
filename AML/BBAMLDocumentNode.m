//
//  BBAMLDocumentNode.m
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLDocumentNode.h"

@implementation BBAMLDocumentNode

- (id)initWithElementName:(NSString *)name attributes:(NSDictionary *)attributeDict andParent:(BBAMLDocumentNode *)parent {
    self = [super init];
    if (self) {
        self.name = [name lowercaseString];
        self.parent = parent;
        self.innerText = @"";
        self.attributes = attributeDict;
        self.children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BBAMLDocumentNode *)addChildWithName:(NSString *)name andAttributes:(NSDictionary *)attributeDict {
    NSString *capitalized = [name capitalizedString];
    NSString *className = [NSString stringWithFormat:@"BBAMLNode%@", capitalized];
    Class nodeType = NSClassFromString(className);
    if (!nodeType) {
        nodeType = [BBAMLDocumentNode class];
    }
    BBAMLDocumentNode *child = [[nodeType alloc] initWithElementName:name attributes:attributeDict andParent:self];
    [self.children addObject:child];
    return child;
}

- (UIView *)view {
    self.nodeView = [[UIView alloc] init];
    [self.nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return nil;
}

- (BBAMLDocumentNode *)getElementById:(NSString *)nodeId {
    NSString *currentId = [self.attributes objectForKey:@"id"];
    if (currentId && [currentId isEqualToString:nodeId]) {
        return self;
    } else {
        for (BBAMLDocumentNode *node in self.children) {
            BBAMLDocumentNode *result = [node getElementById:nodeId];
            if (result) {
                return result;
            }
        }
        return nil;
    }
}

- (void)log {
    NSLog(@"<%@ ... />", self.name);
}

- (void)logTree {
    NSLog(@"<%@>", self.name);
    if (self.children) {
        for (BBAMLDocumentNode *child in self.children) {
            [child logTree];
        }
    }
    if (self.innerText) {
        NSLog(@"%@", self.innerText);
    }
    NSLog(@"</%@>", self.name);
}

@end
