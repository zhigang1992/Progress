//
//  KFCenterViewController.h
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFBaseViewController.h"

@class KFCenterViewController;

@protocol KFCenterViewControllerDelegate <NSObject>
- (void)centerViewWillShowTopView:(KFCenterViewController *)sender;
- (void)centerViewDidFinishShowingTopView:(KFCenterViewController *)sender;
- (BOOL)centerViewShouldShowTopView:(KFCenterViewController *)sender;
@end

@interface KFCenterViewController : KFBaseViewController
@property (nonatomic, weak) id <KFCenterViewControllerDelegate> delegate;
@end