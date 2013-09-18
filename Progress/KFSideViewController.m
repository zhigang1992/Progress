//
//  KFSideViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFSideViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KFSideViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stupidGuideTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stupidGuideButtom;
@end

@implementation KFSideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self.view removeConstraints:@[self.stupidGuideButtom, self.stupidGuideTop]];
    NSDictionary *viewDictionary = @{@"Content": self.contentView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[Content]-20-|" options:0 metrics:nil views:viewDictionary]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
