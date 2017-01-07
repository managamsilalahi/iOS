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
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // self.setupFirstTask()
    }
    
    func setupUI() {
        title = "My Tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }
    
    func setupRealm() {
        // Log in existing user with username and password
        let username = "test"
        let password = "test"
    }
    
    func addTask() {
        let alertController = UIAlertController(title: "New Task", message: "Enter Task Name", preferredStyle: .alert)
        var alertTextField: UITextField!
        
        alertController.addTextField { (textField) in
            alertTextField = textField
            textField.placeholder = "Task Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertTextField.text, !text.isEmpty else { return }
            self.items.append(Task(value: ["text": text]))
            self.tableView.reloadData()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        NotificationToken.stop(self)
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

