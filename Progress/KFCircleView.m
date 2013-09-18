//
//  KFCircleView.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFCircleView.h"

@interface KFCircleView()
@property (nonatomic, strong) UIColor       *strokeColor;
@property (nonatomic, strong) UIColor       *strokeColorLight;
@end

@implementation KFCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    self.backgroundColor = [UIColor clearColor];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat raidus = MIN(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)) /2;
    CGPoint offSet = CGPointMake((point.x - raidus)/raidus, (point.y - raidus)/raidus);
    return offSet.x * offSet.x + offSet.y * offSet.y <= 1.f;
}

- (void)updateStrokeColorsWithTopColorAndButtomColor{
    float topRed, topGreen, topBlue, topAlpha;
    float buttomRed, buttomGreen, buttomBlue, buttomAlpha;
    float strokeRed, strokeGreen, strokeBlue, strokeAlpha;
    if ([self.topColor getRed:&topRed green:&topGreen blue:&topBlue alpha:&topAlpha]) {
        if ([self.buttomColor getRed:&buttomRed green:&buttomGreen blue:&buttomBlue alpha:&buttomAlpha]) {
            strokeRed = (topRed + buttomRed) / 2.f;
            strokeGreen = (topGreen + buttomGreen) / 2.f;
            strokeBlue = (topBlue + buttomBlue) / 2.f;
            strokeAlpha = (topAlpha + buttomAlpha) / 2.f;
            
            float darkenRadio = 0.2f;
            
            self.strokeColor = [UIColor colorWithRed:MAX(strokeRed - darkenRadio, 0) green:MAX(strokeGreen - darkenRadio, 0) blue:MAX(strokeBlue - darkenRadio, 0) alpha:strokeAlpha];
            self.strokeColorLight = [UIColor colorWithRed:strokeRed green:strokeGreen blue:strokeBlue alpha:strokeAlpha / 2.f];
        }
    }
}


- (void)setTopColor:(UIColor *)topColor
{
    _topColor = topColor;
    if (_buttomColor) {
        [self updateStrokeColorsWithTopColorAndButtomColor];
    }
}

- (void)setButtomColor:(UIColor *)buttomColor
{
    _buttomColor = buttomColor;
    if (_topColor) {
        [self updateStrokeColorsWithTopColorAndButtomColor];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* topColor = self.topColor;
    UIColor* buttomColor = self.buttomColor;
    
    UIColor* strokeColor = self.strokeColor;
    UIColor* strokeLight = self.strokeColorLight;
    
    //// Gradient Declarations
    NSArray* blueButtonGradientsColors = [NSArray arrayWithObjects:
                                          (id)topColor.CGColor,
                                          (id)buttomColor.CGColor, nil];
    CGFloat blueButtonGradientsLocations[] = {0, 1};
    CGGradientRef blueButtonGradients = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)blueButtonGradientsColors, blueButtonGradientsLocations);
    
    //// Background Drawing
    UIBezierPath* backgroundPath = [UIBezierPath bezierPathWithOvalInRect: CGRectInset(rect, 0.25, 0.25)];
    [[UIColor whiteColor] setFill];
    [backgroundPath fill];
    [strokeLight setStroke];
    backgroundPath.lineWidth = 0.5;
    [backgroundPath stroke];
    
    
    //// CenterOval Drawing
    CGRect centerViewRect = CGRectInset(rect, self.centerInset.x, self.centerInset.y);
    UIBezierPath* centerOvalPath = [UIBezierPath bezierPathWithOvalInRect: centerViewRect];
    CGContextSaveGState(context);
    [centerOvalPath addClip];
    
    CGPoint topCenter = CGPointMake(CGRectGetMidX(centerViewRect), CGRectGetMinY(centerViewRect));
    CGPoint buttomCenter = CGPointMake(CGRectGetMidX(centerViewRect), CGRectGetMaxY(centerViewRect));
    CGContextDrawLinearGradient(context, blueButtonGradients, topCenter, buttomCenter, 0);
    CGContextRestoreGState(context);
    [strokeColor setStroke];
    centerOvalPath.lineWidth = 0.5;
    [centerOvalPath stroke];
    
    
    //// Cleanup
    CGGradientRelease(blueButtonGradients);
    CGColorSpaceRelease(colorSpace);
}

@end
