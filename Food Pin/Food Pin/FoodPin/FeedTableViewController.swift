//
//  FeedTableViewController.swift
//  FoodPin
//
//  Created by Admin on 4/5/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import CloudKit

class FeedTableViewController: UITableViewController {
    
    var restaurants: [CKRecord] = []
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var imageCache: NSCache = NSCache()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Configure the activity indicator and start animating
        spinner.activityIndicatorViewStyle = .Gray
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        self.parentViewController?.view.addSubview(spinner)
        spinner.startAnimating()
        
        // Pull to Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.whiteColor()
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: "getRecordsFromCloud", forControlEvents: UIControlEvents.ValueChanged)
        
        // Mengambil record dari CloudKit
        self.getRecordsFromCloud()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
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
        return restaurants.count
    }
    
    
    // Fungsi untuk mengambil Record dari CloudKit (API Convenience)
    /* func getRecordsFromCloud() {
        
        //Fetch data using Convenience API
        let cloudContainer = CKContainer.defaultContainer()
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            
            // Jika berhasil
            if error == nil {
                
                print("Completed fetching Restaurant data")
                self.restaurants = results! as [CKRecord]
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
    
            } else {
    
                print(error?.localizedDescription);
                
            }
            
        }
        
        
    }*/
    
    
    // Fungsi untuk mengambil Record dari CloudKit (API Operational)
     func getRecordsFromCloud() {
        
        // Inisialisasi array restoran kosong
        restaurants = []
        
        // Get the Public iCloud Database
        let cloudContainer = CKContainer.defaultContainer()
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        
        //Prepare for query
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the query operation with the query
        let queryOperation = CKQueryOperation(query: query)
        //queryOperation.desiredKeys = ["name", "image"]
        queryOperation.desiredKeys = ["name", "location", "type"]
        queryOperation.queuePriority = .VeryHigh
        queryOperation.resultsLimit = 50
        
        queryOperation.recordFetchedBlock = {
            (record: CKRecord!) -> Void in
            
            if let restaurantRecord = record {
                self.restaurants.append(restaurantRecord)
            }
            
        }
        
        
        queryOperation.queryCompletionBlock = {
            
            (cursor: CKQueryCursor?, error: NSError?) -> Void in
            
            
            // Jika selesai reload semua data, stop spinner
            if self.spinner.isAnimating() {
                dispatch_async(dispatch_get_main_queue(),
                    {
                        self.spinner.stopAnimating()
                })
            }
            
            // Sembunyikan refresh control
            self.refreshControl?.endRefreshing()
            
            if error != nil {
                
                print("Failed to get data from iCloud - \(error?.localizedDescription)")
                
            } else {
                
                print("Successfully retrieve the data from iCloud")
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
            }
            
        }
        
        publicDatabase.addOperation(queryOperation)
        
    }
    
    
    
    // Mengisi row table dengan record dari CloudKit
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
        cell.textLabel!.text = restaurant.objectForKey("name") as? String
        
        if (restaurant.objectForKey("image") != nil) {
            
            let imageAsset = restaurant.objectForKey("image") as! CKAsset
            cell.imageView!.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
            
        }
        

        return cell
    }*/
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FeedTableViewCell
        
        if restaurants.isEmpty {
            return cell
        }
        
        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
        cell.nameLabel!.text = restaurant.objectForKey("name") as? String
        cell.locationLabel!.text = restaurant.objectForKey("location") as? String
        cell.typeLabel!.text = restaurant.objectForKey("type") as? String
        //cell.textLabel!.text = restaurant.objectForKey("name") as? String
    
        
        // Set default camera image
        cell.thumbnailImageView.image = UIImage(named: "camera")
        
        
        // Apakah gambar sudah di cache atau belum
        if let imageFileURL = imageCache.objectForKey(restaurant.recordID) as? NSURL {
            
            print("Get image from cache")
            cell.thumbnailImageView.image = UIImage(data: NSData(contentsOfURL: imageFileURL)!)
            
            
        } else {
            
            // Fetch Image from iCloud in background
            let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
            
            let fetchRecordsImageOperation  = CKFetchRecordsOperation(recordIDs: [restaurant.recordID])
            fetchRecordsImageOperation.desiredKeys = ["image"]
            fetchRecordsImageOperation.queuePriority = .VeryHigh
            fetchRecordsImageOperation.perRecordCompletionBlock = {(record: CKRecord?, recordID: CKRecordID?, error: NSError?) -> Void in
                
                
                if error != nil {
                    print("Failed to get restaurant image: \(error!.localizedDescription)")
                } else {
                    if let restaurantRecord = record {
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            let imageAsset = restaurantRecord.objectForKey("image") as! CKAsset
                            
                            self.imageCache.setObject(imageAsset.fileURL, forKey: restaurant.recordID)
                            
                            cell.thumbnailImageView.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
                            
                        })
                        
                    }
                    
                }
                
            }
            
            publicDatabase.addOperation(fetchRecordsImageOperation)
            
        }
        
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
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
        
        /*if segue.identifier == "showRestaurantDetailFromFeed" {
            
                
            if let indexPath = self.tableView.indexPathForSelectedRow as? UITableViewCell {
            
                
                let destinationController = segue.destinationViewController as! DetailViewController
                
                destinationController.restaurant = restaurants[indexPath.row]
                
                destinationController.hidesBottomBarWhenPushed = true
            }
            
        }*/
        
    }

}
