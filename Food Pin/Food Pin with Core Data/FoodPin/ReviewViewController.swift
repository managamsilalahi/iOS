//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Admin on 3/23/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dialogView: UIView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        
//        Membuat efek blur pada background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
//        Membuat animasi awal dialog view
        let scale = CGAffineTransformMakeScale(0, 0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
        
        title = "Review \(self.restaurant.name)'s Restaurant"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        UIView.animateWithDuration(<#T##duration: NSTimeInterval##NSTimeInterval#>, delay: <#T##NSTimeInterval#>, usingSpringWithDamping: <#T##CGFloat#>, initialSpringVelocity: <#T##CGFloat#>, options: <#T##UIViewAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        UIView.animateWithDuration(0.7, delay: 0.0, options: [], animations: {
            
            //        Membuat animasi akhir dialog view
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
            
            }, completion: nil)
        
    }
}
