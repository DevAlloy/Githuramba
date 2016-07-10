//
// Created by Tsyganov Stanislav on 16/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STVRepo;
@protocol STVReposMapper <NSObject>

- (NSArray<STVRepo *> *)mapReposArrayFromReposRepresentation:(NSArray *)reposRepresentation;

- (STVRepo *)mapRepoDetailsFromRepoRepresentation:(NSDictionary *)repoRepresentation;

@end