//
//  ViewController.swift
//  RealmTasksTutorial
//
//  Created by Managam Silalahi on 1/7/17.
//  Copyright © 2017 Managam. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    var items = List<Task>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupFirstTask()
    }
    
    func setupUI() {
        title = "My Tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupFirstTask() {
        let firstTask = Task(value: ["text": "My First Task"])
        items.append(firstTask)
    }
    
}

// MARK: - UITableViewDatSource

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.text
        cell.textLabel?.alpha = item.completed ? 0.5 : 1
        return cell
    }
}

