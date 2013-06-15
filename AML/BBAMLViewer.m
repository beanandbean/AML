//
//  BBAMLViewer.m
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLViewer.h"

#import "BBAMLStyleSheetParser.h"

#import "BBAMLNodeRoot.h"

@interface BBAMLViewer ()

@property (weak, nonatomic) BBAMLDocumentNode *current;

@property (strong, nonatomic) NSData *data;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (strong, nonatomic) NSArray *fullScreenConstraints;
@property (strong, nonatomic) BBAMLStyleSheetParser *styleSheetParser;

@end

@implementation BBAMLViewer

- (id)initWithAMLData:(NSData *)data andDelegate:(id)delegate andParentView:(UIView *)parent {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.parentView = parent;
        self.data = data;
        self.xmlParser = [[NSXMLParser alloc] initWithData:data];
        self.xmlParser.delegate = self;
        self.xmlParser.shouldProcessNamespaces = NO;
    }
    return self;
}

- (void)view {
    [self.xmlParser parse];
    self.rootView = [self.root view];
    if (self.rootView) {
        [self.parentView addSubview:self.rootView];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.rootView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.parentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0];
        leftConstraint.priority = 1000;
        [self.parentView addConstraint:leftConstraint];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.rootView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.parentView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0.0];
        rightConstraint.priority = 1000;
        [self.parentView addConstraint:rightConstraint];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.rootView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.parentView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:0.0];
        topConstraint.priority = 1000;
        [self.parentView addConstraint:topConstraint];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.rootView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.parentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0
                                                                             constant:0.0];
        bottomConstraint.priority = 1000;
        [self.parentView addConstraint:bottomConstraint];
        self.fullScreenConstraints = [NSArray arrayWithObjects:leftConstraint, rightConstraint, topConstraint, bottomConstraint, nil];
    }
    self.styleSheetParser = [[BBAMLStyleSheetParser alloc] initWithAMLViewer:self];
    [self.styleSheetParser parse];
}

- (void)removeView {
    if ([self.rootView isDescendantOfView:self.parentView]) {
        [self.parentView removeConstraints:self.fullScreenConstraints];
        [self.rootView removeFromSuperview];
        [self.parentView layoutIfNeeded];
    }
}

- (BBAMLDocumentNode *)getElementById:(NSString *)nodeId {
    return [self.root getElementById:nodeId];
}

- (NSArray *)getElementsByPattern:(NSString *)pattern {
    return [self.root getElementsByPattern:pattern];
}

#pragma mark - NSXMLParserDelegate Implement

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (self.root) {
        self.current = [self.current addChildWithName:elementName andAttributes:attributeDict];
    } else {
        self.root = [[BBAMLNodeRoot alloc] initWithElementName:elementName attributes:attributeDict andParent:nil];
        self.root.viewer = self;
        self.current = self.root;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    self.current = self.current.parent;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *trimmed = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![trimmed isEqualToString:@""]) {
        self.current.innerText = [self.current.innerText stringByAppendingString:trimmed];
    }
}

@end

