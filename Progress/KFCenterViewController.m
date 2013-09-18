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
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageForReminderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContentViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentViewForClipingBounds;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropDownHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentViewForShadowing;
@property (weak, nonatomic) IBOutlet KFProgressCircleView *mainProgressView;
@property (nonatomic, getter = isShowingDropDownView) BOOL showingDropDownView;
@property (nonatomic, getter = isShowingReminderView) BOOL showingReminderView;
@property (strong, nonatomic) KFRemindesViewController *remindersViewController;
@property (nonatomic) CGFloat dropDownHight;
@property (nonatomic) CGFloat reminderHight;
@end

@implementation KFCenterViewController
@dynamic dropDownHight;
@dynamic reminderHight;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.contentView.layer.shadowOffset = CGSizeMake(0, -1);
    self.contentViewForClipingBounds.layer.cornerRadius = 10.f;
    self.contentViewForClipingBounds.clipsToBounds = YES;
    
    [self.mainContentView removeConstraint:self.mainContentViewHeightConstraint];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.mainContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:-60-80]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageForReminderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentViewForClipingBounds attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
    
    self.remindersViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"KFRemindesViewController"];
    [self.remindersViewController willMoveToParentViewController:self];
    [self.contentView insertSubview:self.remindersViewController.view belowSubview:self.contentViewForShadowing];
    [self.remindersViewController didMoveToParentViewController:self];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.remindersViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.remindersViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    NSDictionary *reminderViewDictionary = @{@"reminder": self.remindersViewController.view, @"content": self.contentViewForClipingBounds};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[reminder]|" options:0 metrics:nil views:reminderViewDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[content]-(>=-80)-[reminder]" options:0 metrics:nil views:reminderViewDictionary]];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    panGesture.delaysTouchesBegan = YES;
    [self.contentViewForClipingBounds addGestureRecognizer:panGesture];
    
    self.contentViewForShadowing.layer.cornerRadius = 10.f;
    self.contentViewForShadowing.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentViewForShadowing.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.contentViewForShadowing.layer.shadowOpacity = 1;
    self.contentViewForShadowing.layer.shadowRadius = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.contentViewForShadowing.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.contentViewForShadowing.frame cornerRadius:10.f].CGPath;
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

- (CGFloat)dropDownHight
{
    return self.dropDownHeightConstraint.constant;
}

- (void)setDropDownHight:(CGFloat)dropDownHight
{
    
    dropDownHight = MIN(450, MAX(0, dropDownHight));
    
    if (self.dropDownHeightConstraint.constant == dropDownHight) {
        return;
    }
    
    if (self.dropDownHeightConstraint.constant && !dropDownHight && [self.delegate respondsToSelector:@selector(centerViewDidFinishShowingTopView:)]) {
        [self.delegate centerViewDidFinishShowingTopView:self];
    }
    
    if (!self.dropDownHeightConstraint.constant && dropDownHight && [self.delegate respondsToSelector:@selector(centerViewWillShowTopView:)]) {
        [self.delegate centerViewWillShowTopView:self];
    }
    
    self.dropDownHeightConstraint.constant = dropDownHight;
}


- (CGFloat)reminderHight
{
    return -self.mainContentViewTopConstraint.constant;
}

- (void)setReminderHight:(CGFloat)reminderHight
{
    reminderHight = MIN(CGRectGetHeight(self.contentView.frame), MAX(0, reminderHight));
    
    if (self.mainContentViewTopConstraint.constant == -reminderHight) {
        return;
    }
    
    if (self.mainContentViewTopConstraint.constant && !reminderHight && [self.delegate respondsToSelector:@selector(centerViewDidFinishShowingButtomView:)]) {
        [self.delegate centerViewDidFinishShowingButtomView:self];
    }
    
    if (!self.mainContentViewTopConstraint.constant && reminderHight && [self.delegate respondsToSelector:@selector(centerViewWillShowButtomView:)]) {
        [self.delegate centerViewWillShowButtomView:self];
    }
        
    self.mainContentViewTopConstraint.constant = -reminderHight;
    
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    
    if ([self.delegate respondsToSelector:@selector(centerViewShouldShowTopViewOrButtomView:)]) {
        if (![self.delegate centerViewShouldShowTopViewOrButtomView:self]) {
            return;
        }
    }

    CGFloat dropDownViewThroughtHold = CGRectGetHeight(self.mainContentView.frame) * 370/408;
    CGFloat reminderViewThroughtHold = CGRectGetHeight(self.contentView.frame) - 80 + 20;

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint transition = [gesture translationInView:self.view];
            
            CGFloat dropViewHeight = self.dropDownHight;
            CGFloat reminderHeight = self.reminderHight;
            
            if (transition.y > 0) {
                if (fabs(reminderHeight)) {
                    reminderHeight -= transition.y;
                }
                else {
                    if (dropViewHeight > dropDownViewThroughtHold) {
                        CGFloat extraSpace = 450.f - 370.f;
                        CGFloat spaceLeft = dropDownViewThroughtHold + extraSpace - dropViewHeight;
                        dropViewHeight += transition.y * spaceLeft / extraSpace;
                    }
                    else {
                        dropViewHeight += transition.y;
                    }
                }
            } else {
                if (fabs(dropViewHeight)) {
                    dropViewHeight += transition.y;
                }
                else {
                    if (reminderHeight > reminderViewThroughtHold) {
                        CGFloat extraSpace = 80.f;
                        CGFloat spaceLeft = reminderViewThroughtHold + extraSpace - reminderHeight;
                        reminderHeight -= transition.y * spaceLeft / extraSpace;
                    }
                    else {
                        reminderHeight -= transition.y;
                    }
                }
            }
            
            self.dropDownHight = dropViewHeight;
            self.reminderHight = reminderHeight;
            [gesture setTranslation:CGPointZero inView:self.view];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint velocity = [gesture velocityInView:self.view];
            NSTimeInterval duration;

            BOOL shouldShowDropDownView;
            BOOL shouldShowReminderView;
            
            if (self.dropDownHight) {
                shouldShowDropDownView = velocity.y > 100;
                duration = (shouldShowDropDownView ? fabs(dropDownViewThroughtHold - self.dropDownHight) : self.dropDownHight) / (dropDownViewThroughtHold * 2.f);
                shouldShowReminderView = NO;
            }
            else {
                shouldShowReminderView = velocity.y < -100;
                duration = (shouldShowReminderView ? fabs(reminderViewThroughtHold - self.reminderHight) : self.reminderHight) / (reminderViewThroughtHold * 2.f);
                shouldShowDropDownView = NO;
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:fabs(velocity.y / dropDownViewThroughtHold * 2.f) options:0 animations:^{
                self.dropDownHight = shouldShowDropDownView ? dropDownViewThroughtHold : 0;
                self.reminderHight = shouldShowReminderView ? reminderViewThroughtHold : 0;
                [self.contentView layoutIfNeeded];
            } completion:^(BOOL finished) {
            }];
            break;
        }
        default:
            break;
    }
}

@end
