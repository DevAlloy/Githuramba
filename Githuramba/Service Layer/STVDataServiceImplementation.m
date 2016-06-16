//
// Created by Tsyganov Stanislav on 15/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import "STVDataServiceImplementation.h"
#import "STVReposMapper.h"
#import "STVReposMapperImplementation.h"

@implementation STVDataServiceImplementation

- (NSURLSession *)urlSession {
    if (!_urlSession) {
        _urlSession = [NSURLSession sharedSession];
    }
    return _urlSession;
}

- (id <STVReposMapper>)reposMapper {
    if(!_reposMapper) {
        _reposMapper = [STVReposMapperImplementation new];
    }
    return _reposMapper;
}

- (void)obtainRamblerReposWithCompletionBlock:(STVDataServiceReposCompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/orgs/rambler-ios/repos"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask =  [self.urlSession dataTaskWithRequest:request
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             __strong typeof(weakSelf) strongSelf = weakSelf;
                                                             NSArray *repos = [self reposArrayFromReposData:data];
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 completionBlock(repos, error);
                                                             });
                                                         }];
    [dataTask resume];
}

- (void)obtainRamblerRepoDetailForRepoName:(NSString *)repoName withCompletionBlock:(STVDataServiceReposCompletionBlock)completionBlock {
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/repos/rambler-ios/%@", repoName];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask =  [self.urlSession dataTaskWithRequest:request
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             __strong typeof(weakSelf) strongSelf = weakSelf;
                                                             STVRepo *repo = [self repoFromRepoData:data];
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 completionBlock(repo, error);
                                                             });
                                                         }];
    [dataTask resume];
}

- (NSArray *)reposArrayFromReposData:(NSData *)reposData {
    if (!reposData) {
        return nil;
    }
    NSArray *reposRepresentationArray = [NSJSONSerialization JSONObjectWithData:reposData options:0 error:nil];
    NSArray *repos = [self.reposMapper mapReposArrayFromReposRepresentation:reposRepresentationArray];
    return repos;
}

- (STVRepo *)repoFromRepoData:(NSData *)repoData {
    if (!repoData) {
        return nil;
    }
    NSDictionary *repoRepresentationDictionary = [NSJSONSerialization JSONObjectWithData:repoData options:0 error:nil];
    STVRepo *repo = [self.reposMapper mapRepoDetailsFromRepoRepresentation:repoRepresentationDictionary];
    return repo;
}

@end