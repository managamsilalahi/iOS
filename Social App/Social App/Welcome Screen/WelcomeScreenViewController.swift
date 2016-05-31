//
//  WelcomeScreenViewController.swift
//  Social App
//
//  Created by Admin on 5/31/16.
//  Copyright © 2016 Managam. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hidden nav bar
        self.navigationController?.navigationBar.hidden = false
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Hidden nav bar
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set title
        self.title = "Welcome"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbLoggedIn = defaults.boolForKey("fbLoggedIn")
        let googleLoggedIn = defaults.boolForKey("googleLoggedIn")
        
        
        if fbLoggedIn {
            
            let destinationViewController  = FBLoggedInTableViewController()
            self.navigationController?.pushViewController(destinationViewController, animated: true)
            
        } else if googleLoggedIn {
            
            let destinationViewController  = GoogleLoggedInViewController()
            self.navigationController?.pushViewController(destinationViewController, animated: true)
            
        } else {
            
            let destinationControlelr = LoginViewController()
            self.presentViewController(destinationControlelr, animated: true, completion: nil)
            
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
