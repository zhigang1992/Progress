//
//  KFRemindesViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFRemindesViewController.h"
#import "KFSegmentView.h"

#import <QuartzCore/QuartzCore.h>

@interface KFRemindesViewController () <UITableViewDataSource, UITableViewDelegate, KFSegmentViewDelegate>
@property (weak, nonatomic) IBOutlet KFSegmentView *reminderCompleteToggle;
@property (weak, nonatomic) IBOutlet UIView *tableViewContainerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *buttomView;
@end

@implementation KFRemindesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 68, 0);
    self.reminderCompleteToggle.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reminder"];
    return cell;
}

- (void)kfsegmentView:(KFSegmentView *)sender didSelectIndex:(NSInteger)index
{
    [UIView transitionWithView:self.tableViewContainerView duration:0.5f options:index?UIViewAnimationOptionTransitionFlipFromRight:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
