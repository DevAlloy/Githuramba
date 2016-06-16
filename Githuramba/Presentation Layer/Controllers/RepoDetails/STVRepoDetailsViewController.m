//
//  STVRepoDetailsViewController.m
//  Githuramba
//
//  Created by Tsyganov Stanislav on 15/06/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "STVRepoDetailsViewController.h"
#import "STVDataService.h"
#import "STVDataServiceImplementation.h"
#import "STVRepo.h"

@interface STVRepoDetailsViewController ()

@property (nonatomic, strong) STVRepo *repo;

@end

@implementation STVRepoDetailsViewController

#pragma mark - Зависимости
- (id <STVDataService>)dataService {
    if (!_dataService) {
        _dataService = [STVDataServiceImplementation new];
    }
    return _dataService;
}

#pragma mark - Жизненный цикл контроллера
- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    [self.dataService obtainRamblerRepoDetailForRepoName:self.repoName
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
    
}

@end
