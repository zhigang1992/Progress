//
//  KFCircleView.h
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFCircleView : UIView
@property (nonatomic, copy) UIColor *topColor;
@property (nonatomic, copy) UIColor *buttomColor;
@property (nonatomic, getter = isHighlighted) BOOL highlighted;
@property (nonatomic) CGPoint centerInset;
@end
