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
#import "BBAMLOperationAdd.h"
#import "BBAMLOperationMinus.h"
#import "BBAMLOperationMultiply.h"
#import "BBAMLOperationDivide.h"

@interface BBAMLCalculator ()

@property (strong, nonatomic) NSMutableArray *operations;
@property (strong, nonatomic) NSMutableArray *objects;

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
        self.objects = [NSMutableArray arrayWithObject:[[NSMutableArray alloc] init]];
    }
    return self;
}

- (id<BBAMLObjectType>)calculateExpression:(NSString *)expression {
    NSMutableString *buffer = [NSMutableString string];
    expression = [expression stringByAppendingString:@"="];
    for (int index = 0; index < expression.length; index++) {
        char character = [expression characterAtIndex:index];
        if ((character >= '0' && character <= '9') || character == '.') {
            [buffer appendFormat:@"%c", character];
        } else {
            if (buffer.length) {
                [self.objects.lastObject addObject:[[BBAMLTypeNumber alloc] initWithString:buffer]];
                buffer = [NSMutableString string];
            }
            id<BBAMLOperation> operation;
            switch (character) {
                case '+':
                    operation = [[BBAMLOperationAdd alloc] init];
                    break;
                    
                case '-':
                    operation = [[BBAMLOperationMinus alloc] init];
                    break;
                    
                case '*':
                    operation = [[BBAMLOperationMultiply alloc] init];
                    break;
                    
                case '/':
                    operation = [[BBAMLOperationDivide alloc] init];
                    break;
                    
                case '=':
                    operation = [[BBAMLOperationEnd alloc] init];
                    break;
                    
                default:
                    break;
            }
            if (operation) {
                while (operation.priority <= ((id<BBAMLOperation>)self.operations.lastObject).priority) {
                    id<BBAMLObjectType> result = [(id<BBAMLOperation>)self.operations.lastObject operateWithArray:self.objects.lastObject];
                    [self.objects removeLastObject];
                    [self.operations removeLastObject];
                    [self.objects.lastObject addObject:result];
                }
                [self.operations addObject:operation];
                if (operation.needPrecedingObject) {
                    id<BBAMLObjectType> precedingObject = ((NSMutableArray *)self.objects.lastObject).lastObject;
                    [self.objects.lastObject removeLastObject];
                    [self.objects addObject:[NSMutableArray arrayWithObject:precedingObject]];
                } else {
                    [self.objects addObject:[NSMutableArray array]];
                }
            }
        }
    }
    return [[self.objects objectAtIndex:0] objectAtIndex:0];
}

@end
