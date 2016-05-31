//
//  LoginViewController.swift
//  Social App
//
//  Created by Admin on 5/31/16.
//  Copyright © 2016 Managam. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // Register custom view
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapFBSSO(sender: UIButton) {
        
        let loginFB = FBSDKLoginManager()
        loginFB.logInWithReadPermissions(["public_profile"], fromViewController: self) { (result, error) in
            
            if error != nil {
                print(error.localizedDescription)
            } else if result.isCancelled {
                print("Cancelled")
            } else  {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setBool(true, forKey: "fbLoggedIn")
                
                // Goto Welcome Screen and FBLoggedInTableViewController
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
        }
        
    }
    
    @IBAction func didTapGoogleSSO(sender: UIButton) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "googleLoggedIn")
        
        // Goto Welcome Screen and FBLoggedInTableViewController
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
