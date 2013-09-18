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
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentViewForClipingBounds;
@end

@implementation KFCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentView.layer.shadowOffset = CGSizeMake(0, -1);
    self.contentViewForClipingBounds.layer.cornerRadius = 10.f;
    self.contentViewForClipingBounds.clipsToBounds = YES;
    
    [self.mainContentView removeConstraint:self.mainContentViewHeightConstraint];
    [self.contentViewForClipingBounds addConstraint:[NSLayoutConstraint constraintWithItem:self.mainContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentViewForClipingBounds attribute:NSLayoutAttributeHeight multiplier:1 constant:-60-80]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
