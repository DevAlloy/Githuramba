//
// Created by Tsyganov Stanislav on 15/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import "STVDataServiceImplementation.h"


@implementation STVDataServiceImplementation

- (NSURLSession *)urlSession {
    if (!_urlSession) {
        self.urlSession = [NSURLSession sharedSession];
    }
    return _urlSession;
}

- (void)obtainRamblerReposWithCompletionBlock:(STVDataServiceReposCompletionBlock)completionBlock {
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/orgs/rambler-ios/repos"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask *dataTask =  [self.urlSession dataTaskWithRequest:request
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             data = data ?: [NSData data];
                                                             NSArray *repos = [self reposDataFromReposData:data];
                                                         }];
    [dataTask resume];
}

- (void)obtainRamblerRepoDetailForRepoName:(NSString *)repoName withCompletionBlock:(STVDataServiceReposCompletionBlock)completionBlock {

}

- (NSArray *)reposDataFromReposData:(NSData *)reposData {
    NSDictionary *reposDictionary = [NSJSONSerialization JSONObjectWithData:reposData options:0 error:nil];
    return @[];
}

@end