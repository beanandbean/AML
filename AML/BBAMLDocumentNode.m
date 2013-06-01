//
//  BBAMLDocumentNode.m
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLDocumentNode.h"

@interface BBAMLDocumentNode ()

@property (strong, nonatomic) NSSet *classNames;

@end

@implementation BBAMLDocumentNode

- (id)initWithElementName:(NSString *)name attributes:(NSDictionary *)attributeDict andParent:(BBAMLDocumentNode *)parent {
    self = [super init];
    if (self) {
        self.name = [name lowercaseString];
        self.parent = parent;
        self.innerText = @"";
        self.attributes = attributeDict;
        self.children = [[NSMutableArray alloc] init];
        NSString *classes = [self.attributes objectForKey:@"class"];
        if (classes) {
            NSArray *classArray = [classes componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            self.classNames = [NSSet setWithArray:classArray];
        }
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

- (BOOL)matchObjectPattern:(NSString *)pattern {
    NSString *trimmed = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimmed isEqualToString:@"*"]) {
        return YES;
    } else if ([trimmed characterAtIndex:0] == '#') {
        NSString *currentId = [self.attributes objectForKey:@"id"];
        NSString *predictId = [trimmed substringFromIndex:1];
        if ([currentId isEqualToString:predictId]) {
            return YES;
        }
    } else if ([trimmed characterAtIndex:0] == '.') {
        NSString *predictClass = [trimmed substringFromIndex:1];
        return [self.classNames containsObject:predictClass];
    } else {
        if ([trimmed isEqualToString:self.name]) {
            return YES;
        }
    }
    return NO;
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

- (NSArray *)getElementsByPattern:(NSString *)pattern {
    NSString *trimmed = [pattern stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *current;
    NSString *rest;
    if ([trimmed characterAtIndex:0] == '/') {
        current = @"main";
        rest = [[trimmed substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    } else {
        NSRange range = [trimmed rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (range.location == NSNotFound) {
            current = trimmed;
        } else {
            current = [trimmed substringToIndex:range.location];
            rest = [[trimmed substringFromIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    if ([self matchObjectPattern:current]) {
        if (rest) {
            for (BBAMLDocumentNode *node in self.children) {
                [result addObjectsFromArray:[node getElementsByPattern:rest]];
            }
        } else {
            [result addObject:self];
        }
    } else {
        for (BBAMLDocumentNode *node in self.children) {
            [result addObjectsFromArray:[node getElementsByPattern:trimmed]];
        }
    }
    return result;
}

- (void)setBackgroundColor:(UIColor *)color {
    self.nodeView.backgroundColor = color;
}

- (void)setTextColor:(UIColor *)color {
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
}

- (UIView *)view {
    self.nodeView = [[UIView alloc] init];
    [self.nodeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return nil;
}

- (void)log {
    NSLog(@"<%@>", self.name);
    if (self.innerText) {
        NSLog(@"%@", self.innerText);
    }
    NSLog(@"</%@>", self.name);
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
