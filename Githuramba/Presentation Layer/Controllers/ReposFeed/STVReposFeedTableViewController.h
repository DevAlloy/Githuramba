//
//  STVReposFeedTableViewController.h
//  Githuramba
//
//  Created by Tsyganov Stanislav on 15/06/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STVRepoService;

@interface STVReposFeedTableViewController : UITableViewController

@property (nonatomic, strong) id<STVRepoService> dataService;

@end
