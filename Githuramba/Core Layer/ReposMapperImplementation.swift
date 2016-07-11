//
//  ReposMapperImplementation.swift
//  Githuramba
//
//  Created by Tsyganov Stanislav on 10/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

import Foundation

class ReposMapperImplementation: NSObject, ReposMapper {
    
    lazy var dateFormatter: NSDateFormatter! = self.initialDateormatter()
    
    func initialDateormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        return dateFormatter
    }
    
    func mapReposArrayFromReposRepresentation(reposRepresentation: [AnyObject]!) -> [Repo]? {
        var repos: [Repo]?
        for repoRepresentation in reposRepresentation {
            if let repoRepresentation = repoRepresentation as? [NSObject : AnyObject] {
                let repo: Repo? = self.mapRepoDetailsFromRepoRepresentation(repoRepresentation)
                if let repo = repo as Repo! {
                    if repos == nil {
                        repos = []
                    }
                    repos!.append(repo)
                }
            }
        }
        return repos
    }
    
    func mapRepoDetailsFromRepoRepresentation(repoRepresentation: [NSObject : AnyObject]!) -> Repo? {
        
        guard repoRepresentation["id"] != nil else {
            return nil
        }
        var repo: Repo = Repo()
        
        repo.identifier = repoRepresentation["id"] as! NSNumber
        repo.name = repoRepresentation["name"] as! String?
        repo.repoDescription = String(repoRepresentation["description"])
        repo.createdAt = self.dateFormatter.dateFromString(repoRepresentation["created_at"] as! String)
        repo.stars = repoRepresentation["stargazers_count"] as! NSNumber?
        repo.forks = repoRepresentation["forks"] as! NSNumber?
        return repo
    }
}
