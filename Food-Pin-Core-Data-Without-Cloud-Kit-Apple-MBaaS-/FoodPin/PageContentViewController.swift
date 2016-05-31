//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by Admin on 4/4/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var index: Int = 0
    var heading: String = ""
    var subHeading: String = ""
    var imageFile: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)

        // set halaman page control
        pageControl.currentPage = index
        
        //show hidden get started and forward button
        getStartedButton.hidden = (index == 2) ? false : true
        forwardButton.hidden = (index == 2) ? true : false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextScreen(sender: AnyObject) {
        
        let pageViewController = self.parentViewController as! PageViewController
        pageViewController.forward(index)
        
    }
    
    @IBAction func closeScreen(sender: AnyObject) {
        
        // Menggunakan NSUserDefaults supaya Tutorial Food Pin hanya sekali di tampilkan
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalkthrough")
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
