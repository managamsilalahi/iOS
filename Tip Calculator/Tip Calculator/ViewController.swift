//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Admin on 4/22/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // autofocus
        self.inputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func calculateTip(sender: AnyObject) {
        
        let inputString = self.inputTextField.text
        
        // convert slider value to an NSDecimalNumber
        let sliderValue =
            NSDecimalNumber(integer: Int(self.customTipPercentageSlider.value))
        
        // divide sliderValue by decimal100 (100.0) to get tip %
        let customPercent = sliderValue / self.decimal100
        
        // did customTipPercentageSlide generate the event?
        if sender is UISlider {
            
            // thumb moved so update the Labels with new custom percent
            self.customTipPercentLabel1.text = NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: .PercentStyle)
            self.customTipPercentLabel2.text = self.customTipPercentLabel1.text
            
        }
        
        
        
        // if there is a bill amount, calculate tips and totals
        if inputString?.isEmpty != true {
            
            // convert to NSDecimalNumber and insert decimal point
            let billAmount =
                NSDecimalNumber(string: inputString) / self.decimal100
            
            
            // did inputTextField generate the event?
            if sender is UITextField {
                // update billAmountLabel with currency-formatted total
                self.billAmountLabel.text = " " + formatAsCurrency(billAmount)
                
                //calculate and display the 15% tip and total
                let fifteenTip = billAmount * self.decimal15Percent
                self.tip15Label.text = formatAsCurrency(fifteenTip)
                self.total15Label.text = formatAsCurrency(billAmount+fifteenTip)
                
                
            }
            
            
            // calculate custom tip and display custom tip and total
            let customTip = billAmount * customPercent
            self.tipCustomLabel.text = formatAsCurrency(customTip)
            self.totalCustomLabel.text = formatAsCurrency(billAmount+customTip)
            
        }
        
        // clear all labels
        else {
            self.billAmountLabel.text = ""
            self.tipCustomLabel.text = ""
            self.tip15Label.text = ""
            self.totalCustomLabel.text = ""
            self.total15Label.text = ""
            
        }
        
        
        
    }

}



// convert a numeric value to localized currency string
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(
        number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

// overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

// overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

// overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}