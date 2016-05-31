//
//  ViewController.swift
//  Flag Quiz
//
//  Created by Admin on 4/25/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, ModelDelegate {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!

    @IBOutlet var segmentedControls: [UISegmentedControl]!
    
    private var model: Model! // reference to the model object
    
    private let correctColor = UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0)
    private let incorrectColor = UIColor.redColor()
    
    
    private var quizCountries: [String]! = nil // countries in quiz
    private var enabledCountries: [String]! = nil // countries for guesses
    
    private var correctAnswer: String! = nil
    private var correctGuesses = 0
    private var totalGuesses = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create Model
        model = Model(delegate: self)
        settingChanged()
    }
    
    
    // SettingsDelegate: reconfigures quiz when user changes settings: also called when app first loads
    func settingChanged() {
        enabledCountries = model.enabledRegionCountries
        resetQuiz()
        // print(enabledCountries)
    }
    
    
    // start q new quiz
    func resetQuiz() {
        quizCountries = model.newQuizCountries() // countries in new quiz
        correctGuesses = 0
        totalGuesses = 0
        
        //display appropriate # of UISegmentedControls
        for i in 0 ..< segmentedControls.count {
            segmentedControls[i].hidden = (i < model.numberOfGuesses / 2) ? false : true
        }
        
        nextQuestion() // display the first flag in quiz
    }
    
    
    // display nex question
    func nextQuestion() {
        
        questionNumberLabel.text = String(format: "Question \(correctGuesses + 1) of \(model.numberOfQuestions)")
        answerLabel.text = ""
        correctAnswer = quizCountries.removeAtIndex(0)
        flagImageView.image = UIImage(named: correctAnswer) // next flag
        
        // re-enable UISegmentedControls and delete prior segments
        for segmentedControl in segmentedControls {
            segmentedControl.enabled = true
            segmentedControl.removeAllSegments()
        }
        
        // place guesses on displayed UISegmentedControls
        enabledCountries.shuffle()
        
        var i = 0
        
        for segmentedControl in segmentedControls {
            if !(segmentedControl.hidden) {
                var segmentIndex = 0
                
                while segmentIndex < 2 { // 2 per UISegmentedControl
                    if i < enabledCountries.count && correctAnswer != enabledCountries[i] {
                        
                        segmentedControl.insertSegmentWithTitle(countryFromFilename(enabledCountries[i]), atIndex: segmentIndex, animated: true)
                        
                        segmentIndex += 1
                        
                    }
                    
                    i += 1
                
                }
            }
        }
        
        // pick random segment and replace with correct
        let randomRow = Int(arc4random_uniform(UInt32(
            model.numberOfGuesses / 2)))
        let randomIndexInRow = Int(arc4random_uniform(UInt32(2)))
        segmentedControls[randomRow].removeSegmentAtIndex(randomIndexInRow, animated: true)
        segmentedControls[randomRow].insertSegmentWithTitle(countryFromFilename(correctAnswer), atIndex: randomIndexInRow, animated: true)
        
    }
    
    
    
    // converts image filename to displayable guess String
    func countryFromFilename(filename: String) -> String {
        
        var name = filename.componentsSeparatedByString("-")[1]
        let length: Int = name.characters.count
        name = (name as NSString).substringToIndex(length - 4)
        let components = name.componentsSeparatedByString("_")
        return components.joinWithSeparator(" ")
        
    }
    
    
    
    // called when the user makes a guess
    @IBAction func submitGuess(sender: AnyObject) {
        
        // get the title of the bar at the segment, which is the guess
        let guess = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        let correct = countryFromFilename(correctAnswer)
        totalGuesses += 1
        
        if guess != correct {
            
            // disable incorrect guess
            sender.setEnabled(false, forSegmentAtIndex: sender.selectedSegmentIndex)
            answerLabel.textColor = incorrectColor
            answerLabel.text = "Incorrect"
            answerLabel.alpha = 1.0
            UIView.animateWithDuration(1.0, animations: {
                self.answerLabel.alpha = 0.0
            })
            shakeFlag()
            
        } else { // correct guess
            
            answerLabel.textColor = correctColor
            answerLabel.text = guess! + "!"
            answerLabel.alpha = 1.0
            correctGuesses += 1
            
            // disable segmentedControls
            for segmentedControl in segmentedControls {
                
                segmentedControl.enabled = false
                
            }
            
            if correctGuesses == model.numberOfQuestions { // quiz over
                displayQuizResult()
                
            } else { // use GCD to load next flag after 2 seconds
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    self.nextQuestion()
                })
                
            }
            
        }
        
        
    }
    
    
    
    
    
    // shakes the flag to visually indicate incorrect response
    func shakeFlag() {
        
        UIView.animateWithDuration(0.1) { 
            self.flagImageView.frame.origin.x += 16
        }
        
        UIView.animateWithDuration(0.1, delay: 0.1, options: .TransitionNone, animations: {
            self.flagImageView.frame.origin.x -= 32
            }, completion: nil)
        
        UIView.animateWithDuration(0.1, delay: 0.2, options: .TransitionNone, animations: {
            self.flagImageView.frame.origin.x += 32
            }, completion: nil)
        
        UIView.animateWithDuration(0.1, delay: 0.3, options: .TransitionNone, animations: {
            self.flagImageView.frame.origin.x -= 32
            }, completion: nil)
        
        UIView.animateWithDuration(0.1, delay: 0.4, options: .TransitionNone, animations: {
            self.flagImageView.frame.origin.x += 16
            }, completion: nil)
        
    }
    
    
    
    // display quiz result
    func displayQuizResult() {
        
        let percentString = NSNumberFormatter.localizedStringFromNumber(Double(correctGuesses), numberStyle: .PercentStyle)
        
        // create UIAlertController for user input
        let alertController = UIAlertController(title: "Quiz Result", message: String(format: "%1$i guesses, %2$@ correct",
            totalGuesses, percentString), preferredStyle: .Alert)
        
        let newQuizAction = UIAlertAction(title: "New Quiz", style: .Default) { (action) in
            self.resetQuiz()
        }
        
        alertController.addAction(newQuizAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    // called before segue from QuizViewController to SettingsViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showSettings" {
            let controller = segue.destinationViewController as! SettingsViewController
            
            controller.model = model
        }
        
    }
    

}



// Array extension method for shuffling elements
extension Array {
    
    mutating func shuffle() {
        
        // Modern Fisher-Yates shuffle: http://bit.ly/FisherYates
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
        
    }
    
}

