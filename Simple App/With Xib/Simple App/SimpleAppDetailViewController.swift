//
//  SimpleAppDetailViewController.swift
//  Simple App
//
//  Created by Admin on 5/25/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SimpleAppDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var simpleData: Simple!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var previousViewControllerTitle: String!
    
    // Register custom view
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "SimpleAppDetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Register custom table view cell
        tableView.registerNib(UINib(nibName: "SimpleAppDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        // Get image
        self.getImage()
        
        // Caption as title
        self.title = self.simpleData.caption
        
        // Custom table view
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // set title previous is Back
        if self.navigationController!.viewControllers.count > 1 {
            let previousView: UIViewController = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2]
            self.previousViewControllerTitle = previousView.navigationItem.title
            previousView.navigationItem.title = "Back"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Get image
    func getImage() {
        dispatch_async(dispatch_get_main_queue(), {
            if let url = NSURL(string: self.simpleData.imageURL) {
                if let data = NSData(contentsOfURL: url) {
                    self.imageView.image = UIImage(data: data)
                    // self.spinner.stopAnimating()
                }
            }
        })
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleAppDetailTableViewCell
        
        // configure the cell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Caption"
            cell.valueLabel.text = self.simpleData.caption
        case 1:
            cell.fieldLabel.text = "Description"
            cell.valueLabel.text = self.simpleData.description
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
