//
//  KFContentViewForDrawContent.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFContentViewForDrawContentView.h"

@implementation KFContentViewForDrawContentView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if ([self.delegate respondsToSelector:@selector(drawContentView:)]) {
        [self.delegate drawContentView:rect];
    }
}

@end
