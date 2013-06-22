//
//  BBAMLCalculator.m
//  AML
//
//  Created by wangsw on 6/16/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBAMLCalculator.h"

#import "BBAMLOperation.h"

#import "BBAMLTypeNumber.h"

#import "BBAMLOperationNone.h"
#import "BBAMLOperationEnd.h"
#import "BBAMLOperationPositive.h"
#import "BBAMLOperationNegative.h"
#import "BBAMLOperationAdd.h"
#import "BBAMLOperationMinus.h"
#import "BBAMLOperationMultiply.h"
#import "BBAMLOperationDivide.h"
#import "BBAMLOperationBracketBegin.h"
#import "BBAMLOperationBracketEnd.h"

@interface BBAMLCalculator ()

@property (strong, nonatomic) NSMutableArray *operations;

- (id<BBAMLObjectType>)calculateExpression:(NSString *)expression;

@end

@implementation BBAMLCalculator

+ (id<BBAMLObjectType>)calculateExpression:(NSString *)expression {
    BBAMLCalculator *calculator = [[BBAMLCalculator alloc] init];
    return [calculator calculateExpression:expression];
}

- (id)init {
    self = [super init];
    if (self) {
        self.operations = [NSMutableArray arrayWithObject:[[BBAMLOperationNone alloc] init]];
    }
    return self;
}

- (id<BBAMLObjectType>)calculateExpression:(NSString *)expression {
    id<BBAMLOperation> previousOperation = [[BBAMLOperationEnd alloc] init];
    BBAMLOperationEnd *end;
    NSMutableString *buffer = [NSMutableString string];
    expression = [expression stringByAppendingString:@"="];
    for (int index = 0; index < expression.length; index++) {
        char character = [expression characterAtIndex:index];
        if ((character >= '0' && character <= '9') || character == '.') {
            [buffer appendFormat:@"%c", character];
            previousOperation = [[BBAMLOperationNone alloc] init];
        } else {
            if (buffer.length) {
                [((id<BBAMLOperation>)self.operations.lastObject).objects addObject:[[BBAMLTypeNumber alloc] initWithString:buffer]];
                buffer = [NSMutableString string];
            }
            id<BBAMLOperation> operation;
            switch (character) {
                case '=':
                    operation = [[BBAMLOperationEnd alloc] init];
                    end = operation;
                    break;
                    
                case '+':
                    if ([previousOperation class] == [BBAMLOperationNone class] || [previousOperation class] == [BBAMLOperationBracketEnd class]) {
                        operation = [[BBAMLOperationAdd alloc] init];
                    } else {
                        operation = [[BBAMLOperationPositive alloc] init];
                    }
                    break;
                    
                case '-':
                    if ([previousOperation class] == [BBAMLOperationNone class] || [previousOperation class] == [BBAMLOperationBracketEnd class]) {
                        operation = [[BBAMLOperationMinus alloc] init];
                    } else {
                        operation = [[BBAMLOperationNegative alloc] init];
                    }
                    break;
                    
                case '*':
                    operation = [[BBAMLOperationMultiply alloc] init];
                    break;
                    
                case '/':
                    operation = [[BBAMLOperationDivide alloc] init];
                    break;
                    
                case '(':
                    operation = [[BBAMLOperationBracketBegin alloc] init];
                    break;
                    
                case ')':
                    operation = [[BBAMLOperationBracketEnd alloc] init];
                    break;
                    
                default:
                    break;
            }
            if (operation) {
                while (operation.priority <= ((id<BBAMLOperation>)self.operations.lastObject).priority) {
                    id<BBAMLObjectType> result = [(id<BBAMLOperation>)self.operations.lastObject operate];
                    [self.operations removeLastObject];
                    [((id<BBAMLOperation>)self.operations.lastObject).objects addObject:result];
                }
                id<BBAMLObjectType> precedingObject = ((id<BBAMLOperation>)self.operations.lastObject).objects.lastObject;
                if (precedingObject) {
                    [((id<BBAMLOperation>)self.operations.lastObject).objects removeLastObject];
                    operation.preceding = precedingObject;
                }
                [self.operations addObject:operation];
                previousOperation = operation;
            }
        }
    }
    return end.preceding;
}

@end
