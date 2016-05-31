//
//  SettingsViewController.swift
//  Flag Quiz
//
//  Created by Admin on 4/25/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet weak var guessesSegmentedControl: UISegmentedControl!
    
    var model: Model! // set by QuizViewController
    private var regionNames = ["Africa", "Asia", "Europe", "North_America", "Oceania", "South_America"]
    private let defaultRegionIndex = 3
    
    // used to determine whether any settings changed
    private var settingsChanged = false
    
    
    //called when SettingsViewController is displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // select segment based on current number of guesses to display
        guessesSegmentedControl.selectedSegmentIndex = model.numberOfGuesses / 2 - 1
        
        // set switches based on currently selected regions
        for i in 0 ..< switches.count {
            
            switches[i].on = model.regions[regionNames[i]]!
        }
    }

    
    
    // update guesses based on selected segment's index
    @IBAction func numberOfGuessesChanged(sender: UISegmentedControl) {
        
        model.setNumberOfGuesses(2 + sender.selectedSegmentIndex * 2)
        settingsChanged = true
        
    }
    
   // toggle region corresponding to toggled UISwitch
    @IBAction func switchChanged(sender: UISwitch) {
        
        for i in 0 ..< switches.count {
            
            if sender === switches[i] {
                model.toggleRegion(regionNames[i])
                settingsChanged = true
            }
            
        }
        
        
        // if no switches on, default to North America and display error
        if model.regions.filter({$1 == true }).count == 0 {
            
            model.toggleRegion(regionNames[defaultRegionIndex])
            switches[defaultRegionIndex].on = true
            displayErrorDialog()
            
        }
    }
    
    
    // display message that at least on region must be selected
    func displayErrorDialog() {
        
        // create UIAlertController for user input
        let alertController = UIAlertController(title: "At Least One Region Required", message: String(format: "Selecting %@ as the default region.", regionNames[defaultRegionIndex]), preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    // called when user returns to quiz
    override func viewWillDisappear(animated: Bool) {
        
        if settingsChanged {
            
            model.notifyDelegate() // called only if settings changed
            
        }
        
    }
    
    
    
    
}
