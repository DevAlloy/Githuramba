//
// Created by Tsyganov Stanislav on 16/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import "STVReposMapperImplementation.h"
#import "STVRepo.h"


@implementation STVReposMapperImplementation

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        _dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    }
    return _dateFormatter;
}

- (NSArray *)mapReposArrayFromReposRepresentation:(NSArray *)reposRepresentation {
    NSMutableArray *repos = [NSMutableArray new];
    for (NSDictionary *repoRepresentation in reposRepresentation) {
        STVRepo *repo = [self mapRepoDetailsFromRepoRepresentation:repoRepresentation];
        if (!repo) {
            continue;
        }
        [repos addObject:repo];
    }
    return repos;
}

- (STVRepo *)mapRepoDetailsFromRepoRepresentation:(NSDictionary *)repoRepresentation {
    STVRepo *repo = [STVRepo new];
    if (!repoRepresentation[@"id"]) {
        return nil;
    }

    repo.identifier = repoRepresentation[@"id"];
    repo.name = repoRepresentation[@"name"];
    repo.repoDescription = repoRepresentation[@"description"];
    repo.createdAt = [self.dateFormatter dateFromString:repoRepresentation[@"created_at"]];
    repo.stars = repoRepresentation[@"stargazers_count"];
    repo.forks = repoRepresentation[@"forks"];

    return repo;
}

@end