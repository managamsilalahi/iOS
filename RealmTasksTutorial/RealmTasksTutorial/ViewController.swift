//
//  ViewController.swift
//  RealmTasksTutorial
//
//  Created by Managam Silalahi on 1/7/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        title = "My Tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

