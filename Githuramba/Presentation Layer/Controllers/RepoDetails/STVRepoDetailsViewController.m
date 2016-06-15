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

@interface STVRepoDetailsViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
