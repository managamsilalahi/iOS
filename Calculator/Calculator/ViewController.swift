//
//  ViewController.swift
//  Calculator
//
//  Created by Managam Silalahi on 9/6/16.
//  Copyright © 2016 Managam Silalahi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!;
        print("touched \(digit) digit");
    }

}

