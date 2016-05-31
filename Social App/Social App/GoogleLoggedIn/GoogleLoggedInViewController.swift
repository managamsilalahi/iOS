//
//  GoogleLoggedInViewController.swift
//  Social App
//
//  Created by Admin on 5/31/16.
//  Copyright © 2016 Managam. All rights reserved.
//

import UIKit

class GoogleLoggedInViewController: UIViewController {
    
    var previousViewControllerTitle: String!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set title
        self.title = "Google Plus"
        
        // Hidden nav bar
        self.navigationController?.navigationBar.hidden = false
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set title previous is Back
        if self.navigationController!.viewControllers.count > 1 {
            
            // Set back button as logout
            let previousView: UIViewController = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2]
            previousView.navigationItem.title = "Logout"
            self.previousViewControllerTitle = previousView.navigationItem.title
            
            // Set googleLoggedIn as false
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(false, forKey: "googleLoggedIn")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
