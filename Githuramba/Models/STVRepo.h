//
// Created by Tsyganov Stanislav on 15/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STVRepo : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *repoDescription;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSNumber *stars;
@property (nonatomic, copy) NSNumber *forks;

@end