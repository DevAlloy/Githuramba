//
//  STVReposFeedTableViewController.m
//  Githuramba
//
//  Created by Tsyganov Stanislav on 15/06/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "STVReposFeedTableViewController.h"
#import "STVRepoService.h"
#import "STVRamblerRepoServiceImplementation.h"
#import "STVFeedCell.h"
#import "STVRepo.h"

@interface STVReposFeedTableViewController ()

@property (nonatomic, strong) NSArray *repos;
@property (nonatomic, strong) STVRepo *selectedRepo;

@end

@implementation STVReposFeedTableViewController

#pragma mark - Зависимости
- (id <STVRepoService>)dataService {
    if (!_dataService) {
        _dataService = [STVRamblerRepoServiceImplementation new];
    }
    return _dataService;
}

#pragma mark - Жизненный цикл контроллера
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160.f;

    __weak typeof(self) weakSelf = self;
    [self.dataService obtainReposWithCompletionBlock:^(NSArray *repos, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.repos = repos;
        [strongSelf.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Внутренние методы
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    STVRepoDetailsViewController *repoDetailsViewController = segue.destinationViewController;
//    repoDetailsViewController.repoName = self.selectedRepo.name;
    self.selectedRepo = nil;
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STVFeedCell *tableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"feedCell"];
    if (!tableViewCell) {
        tableViewCell = [STVFeedCell new];
        tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self configureCell:tableViewCell withRepo:self.repos[indexPath.row]];

    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRepo = self.repos[indexPath.row];
    [self performSegueWithIdentifier:@"openDetails" sender:self];
}

- (void)configureCell:(STVFeedCell *)tableViewCell withRepo:(STVRepo *)repo {
    tableViewCell.repoNameLabel.text = repo.name;
    tableViewCell.starLabel.text = repo.stars.stringValue;
    tableViewCell.forkLabel.text = repo.forks.stringValue;
    tableViewCell.descriptionLabel.text = repo.repoDescription;
}

@end
