//
//  DetailViewController.m
//  BTSplitViewExample
//
//  Created by Byte on 6/7/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)init
{
    if (self = [super init]) {
        _label = [[UILabel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Display a button to go to master view controller
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_label];
    
    // Center
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}


@end
