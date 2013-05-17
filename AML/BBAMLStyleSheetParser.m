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

- (void)setStyle:(NSString *)style forProperty:(NSString *)property onObject:(BBAMLDocumentNode *)node;

@end

@implementation BBAMLStyleSheetParser

- (id)initWithDocumentRoot:(BBAMLNodeRoot *)root {
    self = [super init];
    if (self) {
        self.root = root;
    }
    return self;
}

- (void)parse {
    NSString *styleSheet = [self.root.styleSheet stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    while (![styleSheet isEqualToString:@""]) {
        NSRange styleBegin = [styleSheet rangeOfString:@"{"];
        if (styleBegin.location == NSNotFound) {
            return;
        }
        NSString *pattern = [[styleSheet substringToIndex:styleBegin.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *rest = [[styleSheet substringFromIndex:styleBegin.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSRange styleEnd = [rest rangeOfString:@"}"];
        NSString *style;
        if (styleEnd.location == NSNotFound) {
            style = rest;
            styleSheet = @"";
        } else {
            style = [[rest substringToIndex:styleEnd.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            styleSheet = [[rest substringFromIndex:styleEnd.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
        if (![style isEqualToString:@""]) {
            NSArray *nodes = [self.root getElementsByPattern:pattern];
            NSArray *styleArray = [style componentsSeparatedByString:@";"];
            for (BBAMLDocumentNode *node in nodes) {
                for (NSString *styleItem in styleArray) {
                    NSString *trimmed = [styleItem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if (![trimmed isEqualToString:@""]) {
                        NSRange range = [trimmed rangeOfString:@":"];
                        if (range.location != NSNotFound) {
                            NSString *property = [[trimmed substringToIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            NSString *styleValue = [[trimmed substringFromIndex:range.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            [self setStyle:styleValue forProperty:property onObject:node];
                        }
                    }
                }
            }
        }
    }
}

- (void)setStyle:(NSString *)style forProperty:(NSString *)property onObject:(BBAMLDocumentNode *)node {
    if ([property isEqualToString:@"background-color"]) {
        if ([style length] == 7 && [style characterAtIndex:0] == '#') {
            unsigned rgbValue = 0;
            NSScanner *scanner = [NSScanner scannerWithString:style];
            [scanner setScanLocation:1];
            [scanner scanHexInt:&rgbValue];
            UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
            node.nodeView.backgroundColor = color;
        }
    } else if ([property isEqualToString:@"width"]) {
        float width = [style floatValue];
        [node.nodeView addConstraint:[NSLayoutConstraint constraintWithItem:node.nodeView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:0.0
                                                                   constant:width]];
    } else if ([property isEqualToString:@"height"]) {
        float height = [style floatValue];
        [node.nodeView addConstraint:[NSLayoutConstraint constraintWithItem:node.nodeView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:0.0
                                                                   constant:height]];
    }
}

@end
