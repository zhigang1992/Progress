//
//  KFContentViewForDrawContent.h
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KFContentViewForDrawContentDelegate <NSObject>
- (void)drawContentView:(CGRect)rect;
@end

@interface KFContentViewForDrawContentView : UIView
@property (nonatomic, weak) id <KFContentViewForDrawContentDelegate> delegate;
@end
