//
// Created by Tsyganov Stanislav on 10/07/16.
// Copyright (c) 2016 DevAlloy. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    lazy var dataService: STVRepoService = self.initialDataService()
    
    var repoName: String?
    lazy var dateFormatter: NSDateFormatter = self.initialDateFormatter()
    var repo: STVRepo?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!

    // MARK: - Зависимости

    func initialDataService() -> STVRepoService {
        let dataService = STVRamblerRepoServiceImplementation()
        return dataService
    }

    func initialDateFormatter() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        return dateFormatter
    }
// MARK: - Жизненный цикл контроллера

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataService.obtainRepoDetailForRepoName(repoName) {[weak self] (repo: STVRepo?, error: NSError?) -> Void in
            if let repo = repo {
                self!.repo = repo
                self!.setupRepo()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - Отображение

    func setupRepo() {
        self.titleLabel.text = self.repo!.name
        self.starLabel.text = self.repo!.stars.stringValue
        self.forkLabel.text = self.repo!.forks.stringValue
        self.descriptionLabel.text = self.repo!.repoDescription
        self.createdAtLabel.text = self.dateFormatter.stringFromDate(self.repo!.createdAt)
    }
}
