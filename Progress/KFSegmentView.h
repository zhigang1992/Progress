//
//  KFSegmentView.h
//  Progress
//
//  Created by Kyle Fang on 9/21/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KFSegmentView;

@protocol KFSegmentViewDelegate <NSObject>
- (void)kfsegmentView:(KFSegmentView *)sender didSelectIndex:(NSInteger)index;
@end

@interface KFSegmentView : UIView
@property (nonatomic, copy) NSString *firstTitle;
@property (nonatomic, copy) NSString *secondTitle;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, weak) id <KFSegmentViewDelegate> delegate;
@end
