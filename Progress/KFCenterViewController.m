//
//  KFCenterViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFCenterViewController.h"
#import "KFProgressCircleView.h"
#import "KFRemindesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KFCenterViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContentViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentViewForClipingBounds;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropDownHeightConstraint;
@property (weak, nonatomic) IBOutlet KFProgressCircleView *mainProgressView;
@property (nonatomic, getter = isShowingDropDownView) BOOL showingDropDownView;
@property (weak, nonatomic) KFRemindesViewController *remindersViewController;
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
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.mainContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:-60-80]];
    
    self.remindersViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"KFRemindesViewController"];
    [self.remindersViewController willMoveToParentViewController:self];
    [self.contentView insertSubview:self.remindersViewController.view belowSubview:self.contentViewForClipingBounds];
    [self.remindersViewController didMoveToParentViewController:self];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.remindersViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    NSDictionary *reminderViewDictionary = @{@"reminder": self.remindersViewController.view, @"content": self.contentViewForClipingBounds};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[reminder]|" options:0 metrics:nil views:reminderViewDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[content]-(-60)-[reminder]" options:0 metrics:nil views:reminderViewDictionary]];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    panGesture.delaysTouchesBegan = YES;
    [self.contentView addGestureRecognizer:panGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.delegate respondsToSelector:@selector(centerViewShouldShowTopViewOrButtomView:)]) {
        return [self.delegate centerViewShouldShowTopViewOrButtomView:self];
    }
    else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    
    if ([self.delegate respondsToSelector:@selector(centerViewShouldShowTopViewOrButtomView:)]) {
        if (![self.delegate centerViewShouldShowTopViewOrButtomView:self]) {
            return;
        }
    }
    
    CGFloat dropDownViewThroughtHold = CGRectGetHeight(self.mainContentView.frame) * 370/408;
    
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            if ([self.delegate respondsToSelector:@selector(centerViewWillShowTopView:)]) {
                [self.delegate centerViewWillShowTopView:self];
            }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint transition = [gesture translationInView:self.view];
            CGFloat drapViewHeight;
            if ([self isShowingDropDownView]) {
                drapViewHeight = dropDownViewThroughtHold;
                if (transition.y > 0) {
                    drapViewHeight += transition.y / 3.f;
                }
                else {
                    drapViewHeight += transition.y;
                }
            }
            else {
                if (transition.y > dropDownViewThroughtHold) {
                    drapViewHeight = dropDownViewThroughtHold + (transition.y - dropDownViewThroughtHold) / 3.f;
                } else {
                    drapViewHeight = transition.y;
                }
            }
            self.dropDownHeightConstraint.constant = MIN(450, MAX(0, drapViewHeight));
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint velocity = [gesture velocityInView:self.view];
            
            BOOL shouldShowDropDownView = velocity.y > 0;// || self.dropDownHeightConstraint.constant > 370.f/2.f;

            NSTimeInterval duration = shouldShowDropDownView ? fabs((dropDownViewThroughtHold - self.dropDownHeightConstraint.constant) / (dropDownViewThroughtHold * 2.f)) : self.dropDownHeightConstraint.constant / (dropDownViewThroughtHold * 2.f);
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:fabs(velocity.y / dropDownViewThroughtHold * 2.f) options:0 animations:^{
                self.dropDownHeightConstraint.constant = shouldShowDropDownView ? dropDownViewThroughtHold : 0.f;
                [self.contentViewForClipingBounds layoutIfNeeded];
            } completion:^(BOOL finished) {
                self.showingDropDownView = shouldShowDropDownView;
                if (!self.showingDropDownView) {
                    if ([self.delegate respondsToSelector:@selector(centerViewDidFinishShowingTopView:)]) {
                        [self.delegate centerViewDidFinishShowingTopView:self];
                    }
                }
            }];
            break;
        }
        default:
            break;
    }
}

@end
