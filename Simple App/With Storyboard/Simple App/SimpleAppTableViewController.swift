//
//  SimpleAppTableViewController.swift
//  Simple App
//
//  Created by Admin on 5/23/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SimpleAppTableViewController: UITableViewController {
    
    var simpleDatas = [Simple]()
    @IBOutlet var spinner: UIActivityIndicatorView!
    var imageCache: NSCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Get Simple data
        self.getSimpleDatas()
        
        // Loading
        self.spinner.hidesWhenStopped = true
        self.spinner.center = view.center
        view.addSubview(self.spinner)
        spinner.startAnimating()
    }
    
    // MARK: Get simple data and append to table view
    func getSimpleDatas() {        
        RestApiManager.sharedInstance.getRandomData { (json) in
            if let results = json.array {
                for entry in results {
                    //print(entry["image_url"])
                    self.simpleDatas.append(Simple(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return simpleDatas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleAppTableViewCell

        // Configure the cell...
        let simpleData = self.simpleDatas[indexPath.row]
        
        // For image caption
        cell.caption.textColor = UIColor.blackColor()
        cell.caption.shadowColor = UIColor.whiteColor()
        cell.caption.text = simpleData.caption
        
        // For default thumbnail image
        cell.thumbnailImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.thumbnailImageView.image = UIImage(named: "photoalbum")
        
        // Check if the image is stored in cache
        if let imageURL = imageCache.objectForKey(simpleData.id) as? NSURL {
            
            // Get image from cache
            print("Get image from cache")
            cell.thumbnailImageView.contentMode = UIViewContentMode.ScaleAspectFill
            cell.thumbnailImageView.image = UIImage(data: NSData(contentsOfURL: imageURL)!)
            
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                if let url = NSURL(string: simpleData.imageURL) {
                    if let data = NSData(contentsOfURL: url) {
                        
                        cell.caption.textColor = UIColor.whiteColor()
                        cell.caption.shadowColor = UIColor.clearColor()
                        
                        cell.thumbnailImageView.contentMode = UIViewContentMode.ScaleAspectFill
                        cell.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            })
            
        }
        
        // Hide right arrow
        cell.accessoryType = .None
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destinationViewController as! SimpleAppDetailViewController
            destinationController.simpleData = self.simpleDatas[indexPath.row]
        }
        
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
    

}
