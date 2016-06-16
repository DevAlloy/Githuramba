//
//  STVRepoDetailsViewController.h
//  Githuramba
//
//  Created by Tsyganov Stanislav on 15/06/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STVDataService;

@interface STVRepoDetailsViewController : UIViewController

@property (nonatomic, strong) id<STVDataService> dataService;
@property (nonatomic, copy) NSString *repoName;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *forkLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@end
