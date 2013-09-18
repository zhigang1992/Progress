//
//  UIView+KFView.h
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KFView)
@property (nonatomic) NSNumber *cornerRadius;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) UIColor *shadowColor;
@property (nonatomic) NSNumber *shadowOpacity;
@property (nonatomic) NSNumber *shadowRadius;
@end
