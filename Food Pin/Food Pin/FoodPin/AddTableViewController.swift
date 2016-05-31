//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by Admin on 3/24/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import CoreData
import CloudKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var restaurant: Restaurant!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var isVisited = true
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func save() {
        
        //        Form validation
        var errorField = ""
        
        if nameTextField.text == "" {
            errorField = "Name"
        } else if locationTextField.text == "" {
            errorField = "Location"
        } else if typeTextField.text == "" {
            errorField = "Type"
        }
        
        
        //        Jika ada field yang error
        if errorField != "" {
            
            let alertController = UIAlertController(title: "Warning", message: "We can't proceed as you forget to fill in the restaurant \(errorField). All fields are mandatory.", preferredStyle: .Alert)
            
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        // If all fields are correctly filled in, extract the field value
        /*print("Name: " + nameTextField.text!)
        print("Type: " + typeTextField.text!)
        print("Location: " + locationTextField.text!)
        print("Have you been here: " + (isVisited ? "Yes" : "No"))*/
        
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as?
            AppDelegate)?.managedObjectContext {
                
                restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant",
                    inManagedObjectContext: managedObjectContext) as! Restaurant
                
                restaurant.name = nameTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = locationTextField.text
                restaurant.image = UIImagePNGRepresentation(imageView.image!)
                
                restaurant.isVisited = isVisited
                
                do {
                    try managedObjectContext.save()
                } catch let e as NSError {
                    print("Error \(e.localizedDescription)")
                }
        }
        
        // Save record to the iCloud
        saveRecordToCloud(restaurant)
        
        
        // Execute the unwind segue and go back to the home screen
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    
    
    @IBAction func updateIsVisited(sender: AnyObject) {
        
        //        Yes button clicked
        let buttonClicked = sender as! UIButton
        
        if buttonClicked == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            noButton.backgroundColor = UIColor.grayColor()
            
        } else if buttonClicked == noButton {
            isVisited = false
            noButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            yesButton.backgroundColor = UIColor.grayColor()
            
        }
        
        
    }
    
    
    
    func saveRecordToCloud(restaurant: Restaurant!) {
        
        // Prepare the record save
        let record = CKRecord(recordType: "Restaurant")
        record.setValue(restaurant.name, forKey: "name")
        record.setValue(restaurant.location, forKey: "location")
        record.setValue(restaurant.type, forKey: "type")
        
        // Resize the image
        let originalImage = UIImage(data: restaurant.image)
        let scalingFactor = (originalImage!.size.width > 1024) ? 1024 / originalImage!.size.width : 1.0
        let scaledImage = UIImage(data: restaurant.image, scale: scalingFactor)
        
        
        // Write the image to local file for temporary use
        let imageFilePath = NSTemporaryDirectory() + restaurant.name
        UIImageJPEGRepresentation(scaledImage!, 0.5)?.writeToFile(imageFilePath, atomically: true)
        
        // Create image asset for upload
        let imageFileURL = NSURL(fileURLWithPath: imageFilePath)
        let imageAsset = CKAsset(fileURL: imageFileURL)
        record.setValue(imageAsset, forKey: "image")
        
        
        // Get the public iCloud Database
        let cloudContainer = CKContainer.defaultContainer()
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        
        // Save the record to iCloud
        publicDatabase.saveRecord(record, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
            
            let fileManager = NSFileManager.defaultManager()
            
            // Remove temp file
            do {
                try fileManager.removeItemAtPath(imageFilePath)
            } catch let e as NSError! {
                print("Failed to save record to the iCloud \(error?.localizedDescription)")
            }
            
            
            
            
        })
        
    }
    
    
}
