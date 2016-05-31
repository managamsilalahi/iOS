//
//  ProfileTableViewController.swift
//  Virtual Tour
//
//  Created by Admin on 5/2/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    
    var etonProperty = RealEstate()
    
    var sectionTiles = []
    var sectionContent = [[]]
    var links = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionTiles = ["Profile", "Contact Us"]
        sectionContent = [["Developer\t: " + etonProperty.developer, "Name\t\t: " + etonProperty.name, "Price\t\t: " + etonProperty.price, "Type\t\t: " + etonProperty.type, "Location\t: " + etonProperty.location], ["Call us", "Visit our website"]]
        links = [etonProperty.phoneNumber, etonProperty.website]
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTiles.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return sectionContent[0].count
        } else {
            return sectionContent[1].count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTiles[section] as? String
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row] as? String
        
        return cell
        
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 4:
                tabBarController?.selectedIndex = 2
            default:
                break
            }
        case 1:
            if let url = NSURL(string: links[indexPath.row] as! String) {
                UIApplication.sharedApplication().openURL(url)
            }
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
     override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label : UILabel = UILabel()
        label.text = sectionTiles[section] as? String
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor(red: 223.0/255.0, green: 61.0/255.0, blue: 74.0/255.0, alpha: 0.8)
        
        return label
    }
    

}
