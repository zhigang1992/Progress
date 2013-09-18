//
//  KFSideViewController.h
//  Progress
//
//  Created by Kyle Fang on 9/17/13.
//  Copyright (c) 2013 Kyle Fang. All rights reserved.
//

#import "KFBaseViewController.h"

@interface KFSideViewController : KFBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *footLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
