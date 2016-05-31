//
//  ShareViewController.swift
//  FoodPin
//
//  Created by Admin on 3/23/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        
        //        Membuat efek blur pada background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        facebookButton.transform = CGAffineTransformMakeTranslation(0, 500)
        emailButton.transform = CGAffineTransformMakeTranslation(0, -500)
        
        messageButton.transform = CGAffineTransformMakeTranslation(0, 500)
        twitterButton.transform = CGAffineTransformMakeTranslation(0, -500)
        
        title = "Share \(self.restaurant.name)'s Restaurant"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        UIView.animateWithDuration(0.6, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: [], animations: {
            

            self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0)
            
            self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0)
            
            self.messageButton.transform = CGAffineTransformMakeTranslation(0, 0)
            
            self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0)
            
            }, completion: nil)
    }
    
}
