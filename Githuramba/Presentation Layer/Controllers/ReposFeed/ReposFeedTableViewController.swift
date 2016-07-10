//
//  ReposFeedTableViewController.swift
//  Githuramba
//
//  Created by Tsyganov Stanislav on 10/07/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

import UIKit

class ReposFeedTableViewController: UITableViewController {
    
    lazy var dataService: STVRepoService = self.initialDataService()
    
    var repos: [STVRepo]?
    var selectedRepo: STVRepo?
    
    // MARK: - Зависимости
    
    func initialDataService() -> STVRepoService {
        let dataService = STVRamblerRepoServiceImplementation()
        return dataService
    }
    // MARK: - Жизненный цикл контроллера
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        
        self.dataService.obtainReposWithCompletionBlock {[weak self] (repos: [STVRepo]?, error: NSError?) in
            if let repos = repos {
                self?.repos = repos;
                self?.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Внутренние методы
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //    STVRepoDetailsViewController *repoDetailsViewController = segue.destinationViewController;
        //    repoDetailsViewController.repoName = self.selectedRepo.name;
        let repoDetailsViewController: RepoDetailsViewController = segue.destinationViewController as! RepoDetailsViewController
        repoDetailsViewController.repoName = selectedRepo?.name;
        self.selectedRepo = nil
    }
    // MARK: - Table view
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.repos != nil) {
            return self.repos!.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier("feedCell")
        
        if let tableViewCell = tableViewCell as? STVFeedCell {
            self.configureCell(tableViewCell, withRepo: self.repos![indexPath.row])
        } else {
            tableViewCell = STVFeedCell()
            tableViewCell!.selectionStyle = .None
        }
        
        return tableViewCell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedRepo = self.repos?[indexPath.row]
        self.performSegueWithIdentifier("openDetails", sender: self)
    }
    
    func configureCell(tableViewCell: STVFeedCell, withRepo repo: STVRepo) {
        tableViewCell.repoNameLabel.text = repo.name
        tableViewCell.starLabel.text = repo.stars.stringValue
        tableViewCell.forkLabel.text = repo.forks.stringValue
        tableViewCell.descriptionLabel.text = repo.repoDescription
    }
    
}