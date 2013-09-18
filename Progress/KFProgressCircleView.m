//
//  KFProgressCircleView.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFProgressCircleView.h"
#import "KFContentViewForDrawContentView.h"

@interface KFProgressCircleView() <KFContentViewForDrawContentDelegate>
@property (strong, nonatomic) KFContentViewForDrawContentView *progressView;
@end

@implementation KFProgressCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self prepareForDrawingContent];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self prepareForDrawingContent];
    }
    return self;
}

- (void)prepareForDrawingContent
{
    self.progressView = [[KFContentViewForDrawContentView alloc] init];
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.delegate = self;
    [self addSubview:self.progressView];
    
    NSDictionary *viewDictionary = @{@"progress": self.progressView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[progress]|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[progress]|" options:0 metrics:nil views:viewDictionary]];
}

- (void)setProgress:(CGFloat)progress
{
    if (_progress != progress) {
        _progress = progress;
        [self.progressView setNeedsDisplay];
    }
}

- (void)drawContentView:(CGRect)rect
{
    if (self.progress <= 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint centerPoint = CGPointMake(rect.size.height / 2.0f, rect.size.width / 2.0f);
    CGFloat radius = MIN(CGRectGetHeight(rect), CGRectGetWidth(rect)) / 2.0f;
    
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = (progress * 2.0f * M_PI) - M_PI_2;
    
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, 3.0f * M_PI_2, radians, NO);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    CGFloat pathWidth = MIN(self.centerInset.x, self.centerInset.y);
    CGFloat centerRadius = radius - pathWidth / 2.f;
    CGFloat xOffset = centerRadius * cosf(radians) + radius;
    CGFloat yOffset = centerRadius * sinf(radians) + radius;
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth / 2.0f, 0.0f, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth / 2.0f, endPoint.y - pathWidth / 2.0f, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat innerRadius = radius - pathWidth;
    CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
    CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius * 2.0f, innerRadius * 2.0f));
    CGContextFillPath(context);
}

@end
