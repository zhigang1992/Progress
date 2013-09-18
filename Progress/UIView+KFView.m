//
//  UIView+KFView.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "UIView+KFView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (KFView)

@dynamic cornerRadius;
@dynamic shadowOffset;
@dynamic shadowOpacity;
@dynamic shadowRadius;
@dynamic shadowColor;

- (NSNumber *)cornerRadius
{
    return @(self.layer.cornerRadius);
}

- (void)setCornerRadius:(NSNumber *)cornerRadius
{
    self.layer.cornerRadius = cornerRadius.doubleValue;
}

- (CGSize)shadowOffset
{
    return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowOffset = shadowOffset;
}

- (NSNumber *)shadowOpacity
{
    return @(self.layer.shadowOpacity);
}

- (void)setShadowOpacity:(NSNumber *)shadowOpacity
{
    self.layer.shadowOpacity = shadowOpacity.doubleValue;
}

- (NSNumber *)shadowRadius
{
    return @(self.layer.shadowRadius);
}

- (void)setShadowRadius:(NSNumber *)shadowRadius
{
    self.layer.shadowRadius = shadowRadius.doubleValue;
}

- (UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}


@end
