//
//  RepoService.swift
//  Githuramba
//
//  Created by Tsyganov Stanislav on 10/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

import Foundation

public typealias STVDataServiceReposCompletionBlock = ([STVRepo]?, NSError!) -> Void
public typealias STVDataServiceRepoDetailCompletionBlock = (STVRepo?, NSError?) -> Void

public protocol RepoService : NSObjectProtocol {
    
    func obtainReposWithCompletionBlock(completionBlock: STVDataServiceReposCompletionBlock?)
    
    func obtainRepoDetailForRepoName(repoName: String!, withCompletionBlock completionBlock: STVDataServiceRepoDetailCompletionBlock?)
}