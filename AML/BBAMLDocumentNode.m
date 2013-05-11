//
//  BBAMLDocumentNode.m
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLDocumentNode.h"

@interface BBAMLDocumentNode ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *children;

@end

@implementation BBAMLDocumentNode

- (id)initWithElementName:(NSString *)name andParent:(BBAMLDocumentNode *)parent {
    self = [super init];
    if (self) {
        self.name = name;
        self.parent = parent;
        self.children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BBAMLDocumentNode *)addChildWithName:(NSString *)name {
    BBAMLDocumentNode *child = [[BBAMLDocumentNode alloc] initWithElementName:name andParent:self];
    [self.children addObject:child];
    return child;
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
