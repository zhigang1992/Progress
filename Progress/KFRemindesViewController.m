//
//  KFRemindesViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/18/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFRemindesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KFRemindesViewController () <UITableViewDataSource, UITableViewDelegate>
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
    self.buttomView.layer.cornerRadius = 10.f;
    self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 68, 0);
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

@end
