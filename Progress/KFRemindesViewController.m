//
//  KFRemindesViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFRemindesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KFRemindesViewController ()
@property (weak, nonatomic) IBOutlet UIView *buttomView;
@end

@implementation KFRemindesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.buttomView.layer.cornerRadius = 10.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
