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

    NSURLSessionDataTask *dataTask =  [self.urlSession dataTaskWithRequest:request
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             data = data ?: [NSData data];
                                                             NSArray *repos = [self reposDataFromReposData:data];
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 completionBlock(repos, error);
                                                             });
                                                         }];
    [dataTask resume];
}

- (void)obtainRamblerRepoDetailForRepoName:(NSString *)repoName withCompletionBlock:(STVDataServiceReposCompletionBlock)completionBlock {

}

- (NSArray *)reposDataFromReposData:(NSData *)reposData {
    if (!reposData) {
        return nil;
    }
    NSArray *reposRepresentationArray = [NSJSONSerialization JSONObjectWithData:reposData options:0 error:nil];
    NSArray *repos = [self.reposMapper mapReposArrayFromReposRepresentation:reposRepresentationArray];
    return repos;
}

@end