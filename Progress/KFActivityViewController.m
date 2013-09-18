//
//  KFActivityViewController.m
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFActivityViewController.h"

@interface KFActivityViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation KFActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    return cell;
}

@end
