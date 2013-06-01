//
//  BBAMLStyleSheetParser.m
//  AML
//
//  Created by wangsw on 5/12/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLStyleSheetParser.h"

#import "BBAMLNodeRoot.h"
#import "BBAMLNodeButton.h"

#import "BBConstantDictionay.h"

@interface BBAMLStyleSheetParser ()

@property (weak, nonatomic) BBAMLViewer *viewer;
@property (weak, nonatomic) BBAMLNodeRoot *root;

- (void)setStyle:(NSString *)style forProperty:(NSString *)property onObject:(BBAMLDocumentNode *)node;

- (NSLayoutConstraint *)constraintForStyle:(NSString *)style forProperty:(int)property onObject:(BBAMLDocumentNode *)node;

- (void)addTargetOnObject:(BBAMLDocumentNode *)node andSelector:(NSString *)selectorString andControlEvent:(int)controlEvent;

+ (UIColor *)colorForStyle:(NSString *)style;

@end

@implementation BBAMLStyleSheetParser

- (id)initWithAMLViewer:(BBAMLViewer *)viewer {
    self = [super init];
    if (self) {
        self.viewer = viewer;
        self.root = (BBAMLNodeRoot *)viewer.root;
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
    int layoutAttribute = [BBConstantDictionay layoutAttribute:property];
    int controlEvent = [BBConstantDictionay controlEvent:property];
    if (layoutAttribute != NSLayoutAttributeNotAnAttribute) {
        [self.root.nodeView addConstraint:[self constraintForStyle:style forProperty:layoutAttribute onObject:node]];
    } else if (controlEvent != -1) {
        [self addTargetOnObject:node andSelector:style andControlEvent:controlEvent];
    } else if ([property isEqualToString:@"backgroundColor"]) {
        [node setBackgroundColor:[BBAMLStyleSheetParser colorForStyle:style]];
    } else if ([property isEqualToString:@"textColor"]) {
        [node setTextColor:[BBAMLStyleSheetParser colorForStyle:style]];
    }
}

- (NSLayoutConstraint *)constraintForStyle:(NSString *)style forProperty:(int)property onObject:(BBAMLDocumentNode *)node {
    UIView *toItem = nil;
    int toProperty = NSLayoutAttributeNotAnAttribute;
    int multiplier = 0.0;
    float constant = 0.0;
    NSString *trimmed = [style stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimmed characterAtIndex:0] == '$') {
        if ([trimmed characterAtIndex:1] == '(') {
            NSRange range = [trimmed rangeOfString:@")"];
            if (range.location != NSNotFound) {
                NSString *pattern = [[[trimmed substringToIndex:range.location] substringFromIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSString *rest = [[trimmed substringFromIndex:range.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([rest characterAtIndex:0] == '.') {
                    BBAMLDocumentNode *toNode;
                    if ([pattern isEqualToString:@"parent"]) {
                        toNode = node.parent;
                    } else {
                        toNode = [[self.root getElementsByPattern:pattern] objectAtIndex:0];
                    }
                    if (toNode) {
                        toItem = toNode.nodeView;
                        NSRange propertyEnd = [rest rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"+-*/"]];
                        if (propertyEnd.location == NSNotFound) {
                            multiplier = 1.0;
                            NSString *strProperty = [[rest substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            toProperty = [BBConstantDictionay layoutAttribute:strProperty];
                        } else {
                            NSString *strProperty = [[[rest substringToIndex:propertyEnd.location] substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
                                                     ];
                            toProperty = [BBConstantDictionay layoutAttribute:strProperty];
                            NSString *calculation = [[rest substringFromIndex:propertyEnd.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            if ([calculation characterAtIndex:0] == '*' || [calculation characterAtIndex:0] == '/') {
                                NSRange multiplierEnd = [calculation rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"+-"]];
                                if (multiplierEnd.location == NSNotFound) {
                                    multiplier = [[[calculation substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] floatValue];
                                } else {
                                    NSString *strMultiplier = [[[calculation substringToIndex:multiplierEnd.location] substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                    multiplier = [strMultiplier floatValue];
                                    NSString *strConstant = [[calculation substringFromIndex:multiplierEnd.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                    constant = [strConstant floatValue];
                                    if ([calculation characterAtIndex:multiplierEnd.location] == '-') {
                                        constant = 0 - constant;
                                    }
                                }
                                if ([calculation characterAtIndex:0] == '/') {
                                    multiplier = 1 / multiplier;
                                }
                            } else {
                                multiplier = 1.0;
                                constant = [[[calculation substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] floatValue];
                                if ([calculation characterAtIndex:0] == '-') {
                                    constant = 0 - constant;
                                }
                            }
                        }
                    }
                }
            }
        }
    } else {
        constant = [trimmed floatValue];
    }
    return [NSLayoutConstraint constraintWithItem:node.nodeView
                                        attribute:property
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:toItem
                                        attribute:toProperty
                                       multiplier:multiplier
                                         constant:constant];
}

- (void)addTargetOnObject:(BBAMLDocumentNode *)node andSelector:(NSString *)selectorString andControlEvent:(int)controlEvent {
    NSString *actionMethod = [selectorString stringByAppendingString:@":"];
    SEL selector = NSSelectorFromString(actionMethod);
    [node addTarget:self.viewer.delegate action:selector forControlEvents:controlEvent];
}


+ (UIColor *)colorForStyle:(NSString *)style {
    if ([style length] == 7 && [style characterAtIndex:0] == '#') {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:style];
        [scanner setScanLocation:1];
        [scanner scanHexInt:&rgbValue];
        UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
        return color;
    } else {
        NSMutableArray *styleComponents = [[style componentsSeparatedByString:@"-"] mutableCopy];
        for (int i = 1; i < styleComponents.count; i++) {
            NSString *word = [styleComponents objectAtIndex:i];
            [styleComponents replaceObjectAtIndex:i withObject:[word capitalizedString]];
        }
        NSString *colorName = [styleComponents componentsJoinedByString:@""];
        NSString *colorMethod = [NSString stringWithFormat:@"%@Color", colorName];
        SEL colorSelector = NSSelectorFromString(colorMethod);
        if ([UIColor respondsToSelector:colorSelector]) {
            return [UIColor performSelector:colorSelector];
        } else {
            return [UIColor clearColor];
        }
    }
}

@end
