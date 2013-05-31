//
//  BBViewController.m
//  AML
//
//  Created by wangsw on 5/10/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBViewController.h"

#import "BBAMLViewer.h"

#import "BBAMLNodeButton.h"

@interface BBViewController ()

@property (strong, nonatomic) BBAMLViewer *amlViewer;

- (IBAction)test:(id)sender;

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

- (IBAction)test:(id)sender {
    NSLog(@"Test passed!");
}

@end
