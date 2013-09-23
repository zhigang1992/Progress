//
//  KFSegmentView.m
//  Progress
//
//  Created by Kyle Fang on 9/21/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFSegmentView.h"
#import "KFGradientView.h"

@implementation KFSegmentView

- (void)setFirstTitle:(NSString *)firstTitle
{
    if (![_firstTitle isEqualToString:firstTitle]) {
        _firstTitle = firstTitle;
        [self setNeedsDisplay];
    }
}

- (void)setSecondTitle:(NSString *)secondTitle
{
    if (![_secondTitle isEqualToString:secondTitle]) {
        _secondTitle = secondTitle;
        [self setNeedsDisplay];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (touchPoint.x < CGRectGetWidth(self.frame) / 2 && self.selectedIndex) {
        [self setSelectedIndex:0];
        if ([self.delegate respondsToSelector:@selector(kfsegmentView:didSelectIndex:)]) {
            [self.delegate kfsegmentView:self didSelectIndex:0];
        }
    }
    else if (touchPoint.x > CGRectGetWidth(self.frame) / 2 && !self.selectedIndex) {
        [self setSelectedIndex:1];
        if ([self.delegate respondsToSelector:@selector(kfsegmentView:didSelectIndex:)]) {
            [self.delegate kfsegmentView:self didSelectIndex:1];
        }
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
    UIColor* topBackground = [UIColor colorWithRed: 0.651 green: 0.894 blue: 0.02 alpha: 1];
    UIColor* buttomBackground = [UIColor colorWithRed: 0.439 green: 0.714 blue: 0.031 alpha: 1];
    UIColor* shadowColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.5];
    UIColor* topFront = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* buttomFront = [UIColor colorWithRed: 0.824 green: 0.824 blue: 0.824 alpha: 1];
    UIColor* stroke = [UIColor colorWithRed: 0.831 green: 0.8 blue: 0.8 alpha: 1];
    UIColor* unselectedTextColor = [UIColor colorWithRed: 0.702 green: 0.702 blue: 0.702 alpha: 1];
    
    //// Gradient Declarations
    NSArray* backgroundColors = [NSArray arrayWithObjects:
                                 (id)topBackground.CGColor,
                                 (id)buttomBackground.CGColor, nil];
    CGFloat backgroundLocations[] = {0, 1};
    CGGradientRef background = CGGradientCreateWithColors(colorSpace, (CFArrayRef)backgroundColors, backgroundLocations);
    NSArray* frontGroundColors = [NSArray arrayWithObjects:
                                  (id)topFront.CGColor,
                                  (id)buttomFront.CGColor, nil];
    CGFloat frontGroundLocations[] = {0, 1};
    CGGradientRef frontGround = CGGradientCreateWithColors(colorSpace, (CFArrayRef)frontGroundColors, frontGroundLocations);
    
    //// Shadow Declarations
    UIColor* shadow = shadowColor2;
    CGSize shadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat shadowBlurRadius = 1.5;
    
    //// Abstracted Attributes
    NSString* leftTextContent = self.firstTitle;
    NSString* rightTextContent = self.secondTitle;
    
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 300, 36) cornerRadius: 18];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, background, CGPointMake(150, 0), CGPointMake(150, 36), 0);
    CGContextRestoreGState(context);
    
    ////// Rounded Rectangle Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    
    if (self.selectedIndex) {
        //// Front Rounded Rectangle Left Drawing
        UIBezierPath* frontRoundedRectangleLeftPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.25, 0.25, 149.5, 35.5) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(18, 18)];
        [frontRoundedRectangleLeftPath closePath];
        CGContextSaveGState(context);
        [frontRoundedRectangleLeftPath addClip];
        CGContextDrawLinearGradient(context, frontGround, CGPointMake(75, 0), CGPointMake(75, 36), 0);
        CGContextRestoreGState(context);
        [stroke setStroke];
        frontRoundedRectangleLeftPath.lineWidth = 0.5;
        [frontRoundedRectangleLeftPath stroke];
    }
    else {
        
        //// Front Rounded Rectangle Right Drawing
        UIBezierPath* frontRoundedRectangleRightPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(150.25, 0.25, 149.5, 35.5) byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(18, 18)];
        [frontRoundedRectangleRightPath closePath];
        CGContextSaveGState(context);
        [frontRoundedRectangleRightPath addClip];
        CGContextDrawLinearGradient(context, frontGround, CGPointMake(225, 0), CGPointMake(225, 36), 0);
        CGContextRestoreGState(context);
        [stroke setStroke];
        frontRoundedRectangleRightPath.lineWidth = 0.5;
        [frontRoundedRectangleRightPath stroke];
    }
    
    //// Left Text Drawing
    CGRect leftTextRect = CGRectMake(17, 8, 116, 26);
    if (!self.selectedIndex) {
        [[UIColor whiteColor] setFill];
    }
    else {
        [unselectedTextColor setFill];
    }
    [leftTextContent drawInRect: leftTextRect withFont: [UIFont fontWithName: @"HelveticaNeue" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    
    //// Right Text Drawing
    CGRect rightTextRect = CGRectMake(167, 8, 116, 26);
    if (self.selectedIndex) {
        [[UIColor whiteColor] setFill];
    }
    else {
        [unselectedTextColor setFill];
    }
    [rightTextContent drawInRect: rightTextRect withFont: [UIFont fontWithName: @"HelveticaNeue" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    
    //// Cleanup
    CGGradientRelease(background);
    CGGradientRelease(frontGround);
    CGColorSpaceRelease(colorSpace);
    
}


@end
