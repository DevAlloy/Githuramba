//
//  STVReposFeedTableViewController.m
//  Githuramba
//
//  Created by Tsyganov Stanislav on 15/06/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "STVReposFeedTableViewController.h"
#import "STVDataService.h"
#import "STVDataServiceImplementation.h"

@interface STVReposFeedTableViewController ()

@property (nonatomic, strong) NSArray *repos;

@end

@implementation STVReposFeedTableViewController

#pragma mark - Зависимости
- (id <STVDataService>)dataService {
    if (!_dataService) {
        _dataService = [STVDataServiceImplementation new];
    }
    return _dataService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.dataService obtainRamblerReposWithCompletionBlock:^(NSArray *repos, NSError *error) {
        self.repos = repos;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Внутренние методы

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}

@end
