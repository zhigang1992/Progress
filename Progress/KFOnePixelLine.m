//
//  KFOnePixelLine.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFOnePixelLine.h"

@interface KFOnePixelLine()
@property (nonatomic, copy) UIColor *lineColor;
@end

@implementation KFOnePixelLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForDrawing];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepareForDrawing];
    }
    return self;
}

- (void)prepareForDrawing
{
    self.drawOnTop = YES;
    self.lineColor = self.backgroundColor;
    self.backgroundColor = [UIColor clearColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath* topLinePath = [UIBezierPath bezierPath];
    if (self.drawOnTop) {
        [topLinePath moveToPoint: CGPointMake(CGRectGetMinX(rect), 0.25)];
        [topLinePath addLineToPoint: CGPointMake(CGRectGetWidth(rect), 0.25)];
    }
    else {
        [topLinePath moveToPoint: CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 0.25)];
        [topLinePath addLineToPoint: CGPointMake(CGRectGetWidth(rect), CGRectGetMaxY(rect) - 0.25)];
    }
    [self.lineColor setStroke];
    topLinePath.lineWidth = 0.5;
    [topLinePath stroke];
}

@end
