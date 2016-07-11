//
//  RamblerRepoServiceImplementation.swift
//  Githuramba
//
//  Created by Tsyganov Stanislav on 10/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

import Foundation

public class STVRamblerRepoServiceImplementation : NSObject, RepoService {
    
    public lazy var reposMapper: ReposMapper! = self.initialReposMapper()
    
    public lazy var urlSession: NSURLSession! = self.initialUrlSession()
    
    
    func initialUrlSession() -> NSURLSession {
        let urlSession = NSURLSession.sharedSession()
        return urlSession
    }
    
    func initialReposMapper() -> ReposMapper {
        let reposMapper = ReposMapperImplementation()
        return reposMapper
    }
    
    public func obtainReposWithCompletionBlock(completionBlock: STVDataServiceReposCompletionBlock?) {
        let url: NSURL = NSURL(string: "https://api.github.com/orgs/rambler-ios/repos")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let dataTask: NSURLSessionDataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: {[weak self] (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let data = data as NSData! {
                let repos: [Repo]? = self?.reposArrayFromReposData(data)
                if let completionBlock = completionBlock as STVDataServiceReposCompletionBlock! {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        completionBlock(repos, error)
                    })
                }
            }
        })
        dataTask.resume()
    }
    
    public func obtainRepoDetailForRepoName(repoName: String!, withCompletionBlock completionBlock: STVDataServiceRepoDetailCompletionBlock?) {
        let urlString: String = "https://api.github.com/repos/rambler-ios/\(repoName)"
        let url: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let dataTask: NSURLSessionDataTask = self.urlSession.dataTaskWithRequest(request, completionHandler: {[weak self] (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let data = data as NSData! {
                let repo: Repo? = self?.repoFromRepoData(data)
                if let completionBlock = completionBlock as STVDataServiceRepoDetailCompletionBlock! {
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        completionBlock(repo, error)
                    })
                }
            }
        })
        dataTask.resume()
    }
    
    func reposArrayFromReposData(reposData: NSData) -> [Repo]? {
        let reposRepresentationArray = try? NSJSONSerialization.JSONObjectWithData(reposData, options: NSJSONReadingOptions.AllowFragments)
        if let reposRepresentationArray = reposRepresentationArray as! [AnyObject]! {
            let repos: [Repo]? = self.reposMapper.mapReposArrayFromReposRepresentation(reposRepresentationArray)
            return repos
        } else {
            return nil;
        }
    }
    
    func repoFromRepoData(repoData: NSData) -> Repo? {
        let repoRepresentationDictionary = try? NSJSONSerialization.JSONObjectWithData(repoData, options: NSJSONReadingOptions.AllowFragments)
        if let repoRepresentationDictionary = repoRepresentationDictionary as! [NSObject: AnyObject]! {
            let repo: Repo? = self.reposMapper.mapRepoDetailsFromRepoRepresentation(repoRepresentationDictionary)
            return repo
        } else {
            return nil;
        }
    }
    
    
}
