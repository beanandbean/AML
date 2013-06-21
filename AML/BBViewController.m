//
//  BBViewController.m
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBViewController.h"

#import "BBAMLViewer.h"
#import "BBAMLCalculator.h"

@interface BBViewController ()

@property (strong, nonatomic) BBAMLViewer *amlViewer;

- (IBAction)calculate:(id)sender;
- (IBAction)reload:(id)sender;

@end

@implementation BBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"aml"];
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
    self.amlViewer = [[BBAMLViewer alloc] initWithAMLData:data andDelegate:self andParentView:self.view];
    [self.amlViewer view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender {
    UITextField *field = (UITextField *)[self.amlViewer getElementById:@"input"].nodeView;
    field.text = [[BBAMLCalculator calculateExpression:field.text] stringValue];
}

- (IBAction)reload:(id)sender {
    [self.amlViewer removeView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"aml"];
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
    self.amlViewer = [[BBAMLViewer alloc] initWithAMLData:data andDelegate:self andParentView:self.view];
    [self.amlViewer view];
}

@end
