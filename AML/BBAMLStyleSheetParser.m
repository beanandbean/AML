//
//  BBAMLStyleSheetParser.m
//  AML
//
//  Created by wangsw on 5/12/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLStyleSheetParser.h"

@interface BBAMLStyleSheetParser ()

@property (weak, nonatomic) BBAMLNodeRoot *root;

@end

@implementation BBAMLStyleSheetParser

- (id)initWithDocumentRoot:(BBAMLNodeRoot *)root {
    self = [super init];
    if (self) {
        self.root = root;
    }
    return self;
}

@end
