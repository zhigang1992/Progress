//
//  KFArrawLineView.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFArrawLineView.h"

@implementation KFArrawLineView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepareForDrawing];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForDrawing];
    }
    return self;
}

- (void)prepareForDrawing
{
    self.backgroundColor = [UIColor clearColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath* arrowLinePath = [UIBezierPath bezierPath];
    
    CGFloat topPointY = CGRectGetMinY(rect) + 0.25f;
    CGFloat buttomPointY = CGRectGetMaxY(rect) - 0.25f;
    
    CGFloat baseLineY = self.pointUp ? buttomPointY : topPointY;
    
    CGFloat arrawHeight = MIN(CGRectGetHeight(rect), self.arrawSize.height) - 0.25;
    
    CGFloat arrawPointY = self.pointUp ? baseLineY - arrawHeight : baseLineY + arrawHeight;
    
    [arrowLinePath moveToPoint: CGPointMake(CGRectGetMinX(rect), baseLineY)];
    [arrowLinePath addLineToPoint: CGPointMake(CGRectGetMidX(rect) - self.arrawSize.width / 2.f, baseLineY)];
    [arrowLinePath addLineToPoint: CGPointMake(CGRectGetMidX(rect), arrawPointY)];
    [arrowLinePath addLineToPoint: CGPointMake(CGRectGetMidX(rect) + self.arrawSize.width / 2.f, baseLineY)];
    [arrowLinePath addLineToPoint: CGPointMake(CGRectGetMaxX(rect), baseLineY)];
    [self.lineColor setStroke];
    arrowLinePath.lineWidth = 0.5f;
    [arrowLinePath stroke];
}


@end
