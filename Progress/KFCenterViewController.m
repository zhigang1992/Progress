//
//  KFCenterViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFCenterViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KFCenterViewController ()
@end

@implementation KFCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.contentView.layer.shadowOffset = CGSizeMake(0, -1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
