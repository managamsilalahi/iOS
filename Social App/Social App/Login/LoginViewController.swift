//
//  LoginViewController.swift
//  Social App
//
//  Created by Admin on 5/31/16.
//  Copyright © 2016 Managam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set title
        self.title = "Login"
        
        // Hidden nav bar
        self.navigationController?.navigationBar.hidden = false
        
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "fbLoggedIn")
        
        // Goto Welcome Screen and FBLoggedInTableViewController
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
