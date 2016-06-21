//
// Created by Tsyganov Stanislav on 15/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STVRepo;

typedef void (^STVDataServiceReposCompletionBlock)(NSArray *repos, NSError *error);
typedef void (^STVDataServiceRepoDetailCompletionBlock)(STVRepo *repo, NSError *error);

@protocol STVRepoService <NSObject>

- (void)obtainReposWithCompletionBlock:(STVDataServiceReposCompletionBlock)completionBlock;

- (void)obtainRepoDetailForRepoName:(NSString *)repoName withCompletionBlock:(STVDataServiceRepoDetailCompletionBlock)completionBlock;

@end