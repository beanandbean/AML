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
@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) BBAMLStyleSheetParser *styleSheetParser;

@end

@implementation BBAMLViewer

- (id)initWithAMLData:(NSData *)data andDelegate:(id)delegate andParentView:(UIView *)parent {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.parent = parent;
        self.data = data;
        self.parser = [[NSXMLParser alloc] initWithData:data];
        self.parser.delegate = self;
        self.parser.shouldProcessNamespaces = NO;
    }
    return self;
}

- (void)view {
    [self.parser parse];
    self.rootView = [self.root view];
    if (self.rootView) {
        [self.parent addSubview:self.rootView];
    }
    self.styleSheetParser = [[BBAMLStyleSheetParser alloc] initWithAMLViewer:self];
    [self.styleSheetParser parse];
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
