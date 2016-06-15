//
// Created by Tsyganov Stanislav on 16/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STVReposMapper <NSObject>

- (NSArray *)mapReposArrayFromReposRepresentation:(NSArray *)reposRepresentation;

- (NSArray *)mapRepoDetailsFromRepoRepresentation:(NSDictionary *)repoRepresentation;

@end