//
//  MasterViewController.swift
//  TwitterSearches
//
//  Created by Admin on 4/25/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, ModelDelegate, UIGestureRecognizerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var model: Model! = nil // manages the app's data
    
    let twitterSearchURL = "https://mobile.twitter.com/search/?q="
    
    //conform to ModelDelegate protocol; updates view when model changes
    func modelDataChanged() {
        tableView.reloadData() // reload the UITableView
    }
    
    
    // configure popover for UITableView on iPad
    override func awakeFromNib() {
        
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MasterViewController.addButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
        model = Model(delegate: self) // create the Model
        model.synchronize() // tell model to sync its data
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // display add/edit dialog
    func displayAddEditSearchAlert(isNew: Bool, index: Int?) {
        
        // create UIAlertController for user input
        let alertController = UIAlertController(title: isNew ? "Add Search" : "Edit Search", message: isNew ? "" : "Modify your query", preferredStyle: .Alert)
        
        // create UITextFields in which user can enter a new search
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
            if isNew {
                textField.placeholder = "Enter Twitter search query"
            } else {
                textField.text = self.model.queryForTagAtIndex(index!)
            }
            
        }
        
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
            if isNew {
                textField.placeholder = "Tag your query"
            } else {
                textField.text = self.model.tagAtIndex(index!)
                textField.enabled = false
                textField.textColor = UIColor.lightGrayColor()
            }
        }
        
        
        // create Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        
        alertController.addAction(cancelAction)
        
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
            
            let query = (alertController.textFields![0] as UITextField).text
            let tag = (alertController.textFields![1] as UITextField).text
            
            
            // ensure query and tag are not empty
            if !(query?.isEmpty)! && !(tag?.isEmpty)! {
                
                self.model.saveQuery(query!, forTag: tag!, syncToCloud: true)
                
                if isNew {
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            }
            
        }
        
        
        alertController.addAction(saveAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    // displays a UIAlertController to obtain new search from user
    func addButtonPressed(sender: AnyObject) {
        displayAddEditSearchAlert(true, index: nil)
    }
    
    
    // return a URL encoded version of the query string
    func urlEncodeString(string: String) -> String {
        
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
    }
    
    // display share sheet
    func shareSearch(index: Int) {
        
        let message = "Check out the result of this Twitter search"
        let urlString = self.twitterSearchURL + urlEncodeString(model.queryForTagAtIndex(index))
        
        let itemsToShare = [message, urlString]
        
        // create UIActivityViewController so user can chare search
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    
    // displays the edit/share options
    func displayLongPressOptions(row: Int) {
        
        // create UIAlertController for user input
        let alertController = UIAlertController(title: "Options", message: "Edit or Share your search", preferredStyle: .Alert)
        
        // create Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // create Edit Action
        let editAction = UIAlertAction(title: "Edit", style: .Default) { (action) in
            
            self.displayAddEditSearchAlert(false, index: row)
            
        }
        alertController.addAction(editAction)
        
        // create Share Action
        let shareAction = UIAlertAction(title: "Share", style: .Default, handler: { (action) in self.shareSearch(row) })
        
        
        alertController.addAction(shareAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    // handles long press for editing or sharing a search
    func tableViewCellLongPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == .Began && !(tableView.editing) {
            
            let cell = sender.view as! UITableViewCell // get cell
            
            if let indexPath = tableView.indexPathForCell(cell) {
                displayLongPressOptions(indexPath.row)
            }
            
        }
        
    }
    
    
    /* func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
             
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject.setValue(NSDate(), forKey: "timeStamp")
             
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    } */

    // MARK: - Segues

    /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    } */
    
    
    // called when app is about to seque from
    // MasterViewController to DetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                //get query String
                let query = String(model.queryForTagAtIndex(indexPath.row))
                
                // create NSURL to perform Twitter Search
                controller.detailItem = NSURL(string: self.twitterSearchURL + urlEncodeString(query))
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                
                controller.navigationItem.leftItemsSupplementBackButton = true
                
            }
            
        }
        
    }
    

    // MARK: - Table View

    /* override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    } */
    
    // callback that returns total number of sections in UITableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    /* override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    } */
    
    // callback that returns number of rows if the UITableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    /* override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.configureCell(cell, withObject: object)
        return cell
    } */
    
    
    
    // handles long press for editing or sharing a search
    func tableViewCellLongPressed(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began && !(tableView.editing) {
            
            
            let cell = sender.view as! UITableViewCell // get cell
            
            if let indexPath = tableView.indexPathForCell(cell) {
                displayLongPressOptions(indexPath.row)
            }
            
        }
        
    }
    
    
    
    
    // callback that returns a configured cell for the given NSIndexPath
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // get cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // set cell label's text to the taf at the specified index
        cell.textLabel!.text = model.tagAtIndex(indexPath.row)
        
        // set up long press gesture recognizer
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MasterViewController.tableViewCellLongPressed(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
        return cell
        
    }

    
    
    
    /* override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    } */
    
    // callback that returns whether a cell is editable
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }



    /* override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    } */
    
    
    // callback that deletes a row from the UITableView
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch editingStyle {
        case .Delete:
            model.deleteSearchAtIndex(indexPath.row)
            
            // remove UITableView row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            break
        }
        
    }
    
    
    // callback that returns whether cells can be moved
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    // callback that reorders keys when user moves them in the table
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        // tell model to reorder tags based on UITableView order
        model.moveTagAtIndex(sourceIndexPath.row, toDestinationIndex: destinationIndexPath.row)
        
    }
    
    
    

    func configureCell(cell: UITableViewCell, withObject object: NSManagedObject) {
        cell.textLabel!.text = object.valueForKey("timeStamp")!.description
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //print("Unresolved error \(error), \(error.userInfo)")
             abort()
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, withObject: anObject as! NSManagedObject)
            case .Move:
                tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

