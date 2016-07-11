//
//  ReposMapper.swift
//  Githuramba
//
//  Created by Tsyganov Stanislav on 10/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

import Foundation

public protocol ReposMapper : NSObjectProtocol {
    
    func mapReposArrayFromReposRepresentation(reposRepresentation: [AnyObject]!) -> [Repo]?
    
    func mapRepoDetailsFromRepoRepresentation(repoRepresentation: [NSObject : AnyObject]!) -> Repo?
}
