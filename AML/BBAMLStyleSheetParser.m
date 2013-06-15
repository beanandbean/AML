//
//  BBAMLStyleSheetParser.m
//  AML
//
//  Created by wangsw on 5/12/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLStyleSheetParser.h"

#import "BBAMLNodeRoot.h"

#import "BBAMLAnimation.h"

#import "BBAMLConstantDictionary.h"

@interface BBAMLStyleSheetParser ()

@property (nonatomic) int priority;

@property (weak, nonatomic) BBAMLViewer *viewer;
@property (weak, nonatomic) BBAMLNodeRoot *root;

@property (strong, nonatomic) NSMutableDictionary *animations;

- (void)parseStyle:(NSString *)style forPattern:(NSString *)pattern;

- (void)setStyle:(NSString *)style forProperty:(NSString *)property onObject:(BBAMLDocumentNode *)node;

- (void)addTargetOnObject:(BBAMLDocumentNode *)node withAction:(NSString *)action andControlEvent:(int)controlEvent;

- (NSLayoutConstraint *)constraintForStyle:(NSString *)style forProperty:(int)property onObject:(BBAMLDocumentNode *)node withPriority:(int)priority;

+ (UIColor *)colorForStyle:(NSString *)style;

@end

@implementation BBAMLStyleSheetParser

- (id)initWithAMLViewer:(BBAMLViewer *)viewer {
    self = [super init];
    if (self) {
        self.viewer = viewer;
        self.root = (BBAMLNodeRoot *)viewer.root;
        self.animations = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)parse {
    NSString *styleSheet = [self.root.styleSheet stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self parseStyleSheet:styleSheet];
}

- (void)parseStyleSheet:(NSString *)styleSheet {
    while (![styleSheet isEqualToString:@""]) {
        NSRange styleBegin = [styleSheet rangeOfString:@"{"];
        if (styleBegin.location == NSNotFound) {
            return;
        }
        NSString *pattern = [[styleSheet substringToIndex:styleBegin.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *rest = [[styleSheet substringFromIndex:styleBegin.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        int count = 1, i;
        for (i = 0; i < rest.length; i++) {
            if ([rest characterAtIndex:i] == '{') {
                count++;
            } else if ([rest characterAtIndex:i] == '}') {
                count--;
                if (count <= 0) {
                    break;
                }
            }
        }
        NSString *style;
        if (count > 0) {
            style = rest;
            styleSheet = @"";
        } else {
            style = [[rest substringToIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            styleSheet = [[rest substringFromIndex:i + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
        if (![style isEqualToString:@""]) {
            [self parseStyle:style forPattern:pattern];
        }
    }
    [self.root.nodeView layoutIfNeeded];
}

- (void)parseStyle:(NSString *)style forPattern:(NSString *)pattern {
    if ([pattern characterAtIndex:0] == '@') {
        pattern = [pattern substringFromIndex:1];
        if ([[pattern substringToIndex:10] isEqualToString:@"animation "]) {
            NSString *animationDetail = [[pattern substringFromIndex:10] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSRange range = [animationDetail rangeOfCharacterFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            float duration = 1.0;
            NSString *animationName;
            if (range.location == NSNotFound) {
                animationName = animationDetail;
            } else {
                animationName = [[animationDetail substringToIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSString *animationDuration = [[animationDetail substringFromIndex:range.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                duration = [animationDuration floatValue];
                duration = duration == 0.0 ? 1.0 : duration;
            }
            [self.animations setObject:[[BBAMLAnimation alloc] initWithAnimationStyleSheet:style duration:duration andDelegate:self] forKey:animationName];
        }
    } else {
        NSArray *nodes = [self.root getElementsByPattern:pattern];
        NSArray *styleArray = [style componentsSeparatedByString:@";"];
        for (BBAMLDocumentNode *node in nodes) {
            self.priority = 500;
            for (NSString *styleItem in styleArray) {
                NSString *trimmed = [styleItem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (![trimmed isEqualToString:@""]) {
                    int slash = 0;
                    while (slash < trimmed.length && [trimmed characterAtIndex:slash] == '/') {
                        slash++;
                        if (slash > 1) {
                            break;
                        }
                    }
                    if (slash > 1) {
                        continue;
                    }
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

- (void)setStyle:(NSString *)style forProperty:(NSString *)property onObject:(BBAMLDocumentNode *)node {
    if ([property characterAtIndex:0] == '@') {
        property = [property substringFromIndex:1];
        if ([property isEqualToString:@"priority"]) {
            self.priority = style.intValue;
            self.priority = self.priority > 1000 ? 1000 : self.priority;
        }
    } else {
        int priority = self.priority;
        NSRange range = [style rangeOfString:@"!"];
        if (range.location != NSNotFound) {
            NSString *strPriority = [style substringFromIndex:range.location + 1];
            style = [style substringToIndex:range.location];
            if (strPriority.length) {
                priority = strPriority.intValue;
                priority = priority > 1000 ? 1000 : priority;
            } else {
                priority = 1000;
            }
        }
        int layoutAttribute = [BBAMLConstantDictionary layoutAttribute:property];
        int controlEvent = [BBAMLConstantDictionary controlEvent:property];
        if (layoutAttribute != NSLayoutAttributeNotAnAttribute) {
            [self.root.nodeView addConstraint:[self constraintForStyle:style forProperty:layoutAttribute onObject:node withPriority:priority]];
        } else if (controlEvent != -1) {
            [self addTargetOnObject:node withAction:style andControlEvent:controlEvent];
        } else if ([property isEqualToString:@"backgroundColor"]) {
            [node setBackgroundColor:[BBAMLStyleSheetParser colorForStyle:style]];
        } else if ([property isEqualToString:@"textColor"]) {
            [node setTextColor:[BBAMLStyleSheetParser colorForStyle:style]];
        } else if ([property isEqualToString:@"hidden"]) {
            if ([style isEqualToString:@"YES"]) {
                [node setHidden:YES];
            } else if ([style isEqualToString:@"NO"]) {
                [node setHidden:NO];
            }
        }
    }
}

- (void)addTargetOnObject:(BBAMLDocumentNode *)node withAction:(NSString *)action andControlEvent:(int)controlEvent {
    if ([action characterAtIndex:0] == '@') {
        NSString *actionMethod = [[action substringFromIndex:1] stringByAppendingString:@":"];
        SEL selector = NSSelectorFromString(actionMethod);
        [node addTarget:self.viewer.delegate action:selector forControlEvents:controlEvent];
    } else {
        BBAMLAnimation *animation = [self.animations objectForKey:action];
        if (animation) {
            [node addTarget:animation action:@selector(runAnimation:) forControlEvents:controlEvent];
        }
    }
}

- (NSLayoutConstraint *)constraintForStyle:(NSString *)style forProperty:(int)property onObject:(BBAMLDocumentNode *)node withPriority:(int)priority {
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
                            toProperty = [BBAMLConstantDictionary layoutAttribute:strProperty];
                        } else {
                            NSString *strProperty = [[[rest substringToIndex:propertyEnd.location] substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
                                                     ];
                            toProperty = [BBAMLConstantDictionary layoutAttribute:strProperty];
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
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:node.nodeView
                                                                  attribute:property
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toItem
                                                                  attribute:toProperty
                                                                 multiplier:multiplier
                                                                   constant:constant];
    [constraint setPriority:priority];
    return constraint;
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
