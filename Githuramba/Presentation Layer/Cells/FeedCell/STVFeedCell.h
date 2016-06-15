//
// Created by Tsyganov Stanislav on 16/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STVFeedCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *repoNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *starLabel;
@property (nonatomic, weak) IBOutlet UILabel *forkLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end