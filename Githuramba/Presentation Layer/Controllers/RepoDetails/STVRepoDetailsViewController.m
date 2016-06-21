//
//  STVRepoDetailsViewController.m
//  Githuramba
//
//  Created by Tsyganov Stanislav on 15/06/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "STVRepoDetailsViewController.h"
#import "STVRepoService.h"
#import "STVRamblerRepoServiceImplementation.h"
#import "STVRepo.h"

@interface STVRepoDetailsViewController ()

@property (nonatomic, strong) STVRepo *repo;

@end

@implementation STVRepoDetailsViewController

#pragma mark - Зависимости
- (id <STVRepoService>)dataService {
    if (!_dataService) {
        _dataService = [STVRamblerRepoServiceImplementation new];
    }
    return _dataService;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    }
    return _dateFormatter;
}

#pragma mark - Жизненный цикл контроллера
- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    [self.dataService obtainRepoDetailForRepoName:self.repoName
                              withCompletionBlock:^(STVRepo *repo, NSError *error) {
                                  __strong typeof(weakSelf) strongSelf = weakSelf;
                                  strongSelf.repo = repo;
                                  [strongSelf setupRepo];
                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Отображение
- (void)setupRepo {
    self.titleLabel.text = self.repo.name;
    self.starLabel.text = self.repo.stars.stringValue;
    self.forkLabel.text = self.repo.forks.stringValue;
    self.descriptionLabel.text = self.repo.repoDescription;
    self.createdAtLabel.text = [self.dateFormatter stringFromDate:self.repo.createdAt];
}

@end
