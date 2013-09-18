//
//  KFCenterViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFCenterViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KFCenterViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentViewForClipingBounds;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropDownHeightConstraint;
@property (nonatomic, getter = isShowingDropDownView) BOOL showingDropDownView;
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
    if ([self.delegate respondsToSelector:@selector(centerViewShouldShowTopView:)]) {
        return [self.delegate centerViewShouldShowTopView:self];
    }
    else {
        return YES;
    }
//    CGPoint touchPoint = [gestureRecognizer locationInView:self.contentView];
//    return CGRectContainsPoint(CGRectInset(self.contentView.frame, 10, 0), touchPoint);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    
    if ([self.delegate respondsToSelector:@selector(centerViewShouldShowTopView:)]) {
        if (![self.delegate centerViewShouldShowTopView:self]) {
            return;
        }
    }
    
    
    
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
                drapViewHeight = 370.f;
                if (transition.y > 0) {
                    drapViewHeight += transition.y / 3.f;
                }
                else {
                    drapViewHeight += transition.y;
                }
            }
            else {
                if (transition.y > 370.f) {
                    drapViewHeight = 370.f + (transition.y - 370.f) / 3.f;
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

            NSTimeInterval duration = shouldShowDropDownView ? fabs((370.f - self.dropDownHeightConstraint.constant) / 740.f) : self.dropDownHeightConstraint.constant / 740.f;
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:fabs(velocity.y / 740.f) options:0 animations:^{
                self.dropDownHeightConstraint.constant = shouldShowDropDownView ? 370.f : 0.f;
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
