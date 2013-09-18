//
//  KFViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFViewController.h"
#import "KFCenterViewController.h"

@interface KFViewController () <UIScrollViewDelegate, KFCenterViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *statusBarShadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpaceOfContentViewLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeightConstrait;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollViewContentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIViewController *leftViewController;
@property (strong, nonatomic) UIViewController *centerViewController;
@property (strong, nonatomic) UIViewController *rightViewController;
@property (strong, nonatomic) NSLayoutConstraint *leftCenterConstraint;
@property (strong, nonatomic) NSLayoutConstraint *rightCenterConstraint;
@end

@implementation KFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.scrollViewContentView removeConstraint:self.scrollViewContentHeightConstrait];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollViewContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
    self.leftViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"] ;
    self.centerViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EgentViewController"];
    self.rightViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.leftViewController willMoveToParentViewController:self];
    [self.contentView addSubview:self.leftViewController.view];
    [self.leftViewController didMoveToParentViewController:self];
    
    [self.rightViewController willMoveToParentViewController:self];
    [self.contentView addSubview:self.rightViewController.view];
    [self.rightViewController didMoveToParentViewController:self];
    
    [self.centerViewController willMoveToParentViewController:self];
    [self.contentView addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
    
    [(KFCenterViewController *)self.centerViewController setDelegate:self];
    
    NSDictionary *viewDictionary = @{@"left": self.leftViewController.view,
                                     @"center": self.centerViewController.view,
                                     @"right": self.rightViewController.view};
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.centerViewController.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[left(320)]-(>=-80)-[center(320)]-(>=-80)-[right(320)]" options:(NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom) metrics:nil views:viewDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[left]|" options:0 metrics:nil views:viewDictionary]];
    
    self.leftCenterConstraint = [NSLayoutConstraint constraintWithItem:self.leftViewController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.centerViewController.view attribute:NSLayoutAttributeLeft multiplier:1 constant:80];
    self.rightCenterConstraint = [NSLayoutConstraint constraintWithItem:self.rightViewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.centerViewController.view attribute:NSLayoutAttributeRight multiplier:1 constant:-80];
    [self.contentView addConstraints:@[self.leftCenterConstraint, self.rightCenterConstraint]];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(960, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.contentOffset = CGPointMake(320, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    self.leadingSpaceOfContentViewLayoutConstraint.constant = 80 * (MIN(MAX(xOffset, 0), 640) - 320) / 320;
    if (xOffset <= 0) {
        self.leftCenterConstraint.constant = 80 + xOffset / 2.f;
    }
    else if (xOffset >= 640) {
        self.rightCenterConstraint.constant = -80 + (xOffset - 640) / 2.f;
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

//KFCenterViewControllerDelegate
- (BOOL)centerViewShouldShowTopViewOrButtomView:(KFCenterViewController *)sender
{
    return (self.scrollView.contentOffset.x == 320);
}

- (void)centerViewWillShowTopView:(KFCenterViewController *)sender
{
    self.scrollView.scrollEnabled = NO;
}

- (void)centerViewDidFinishShowingTopView:(KFCenterViewController *)sender
{
    self.scrollView.scrollEnabled = YES;
}

- (void)centerViewWillShowButtomView:(KFCenterViewController *)sender
{
    self.statusBarShadowView.hidden = NO;
    self.scrollView.scrollEnabled = NO;
}

- (void)centerViewDidFinishShowingButtomView:(KFCenterViewController *)sender
{
    self.statusBarShadowView.hidden = YES;
    self.scrollView.scrollEnabled = YES;
}

@end
