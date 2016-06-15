//
// Created by Tsyganov Stanislav on 15/06/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STVDataService.h"

@interface STVDataServiceImplementation : NSObject <STVDataService>

@property (nonatomic, strong) NSURLSession *urlSession;

@end