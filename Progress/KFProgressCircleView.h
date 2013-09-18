//
//  KFProgressCircleView.h
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFCircleView.h"

@interface KFProgressCircleView : KFCircleView
@property (nonatomic) CGFloat progress;
@property (strong, nonatomic) UIColor *progressColor;
@end
