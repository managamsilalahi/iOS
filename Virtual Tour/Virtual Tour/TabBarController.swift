//
//  TabBarController.swift
//  Virtual Tour
//
//  Created by Admin on 5/2/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillLayoutSubviews() {
        
        var tabFrame: CGRect = self.tabBar.frame
        tabFrame.size.height = 70
        tabFrame.origin.y = self.view.frame.size.height - 60
        self.tabBar.frame = tabFrame
        
    }

}
