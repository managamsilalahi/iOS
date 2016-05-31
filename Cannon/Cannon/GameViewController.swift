//
//  GameViewController.swift
//  Cannon
//
//  Created by Admin on 4/28/16.
//  Copyright (c) 2016 Morra. All rights reserved.
//

import AVFoundation
import UIKit
import SpriteKit

// sounds defined once and reused throughout app
var blockerHitSound: AVAudioPlayer!
var targetHitSound: AVAudioPlayer!
var cannonFireSound: AVAudioPlayer!


class GameViewController: UIViewController {

    // called when GameViewController is displayed on screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // load sound when view controller loads
        do {
            try blockerHitSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("blocker_hit", ofType: "wav")!))
        } catch {
            print(ErrorType)
        }
        
        do {
            try targetHitSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("target_hit", ofType: "wav")!))
        } catch {
            print(ErrorType)
        }
        
        do {
            try cannonFireSound = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cannon_fire", ofType: "wav")!))
        } catch {
            print(ErrorType)
        }
        
        
        
        let scene = GameScene(size: view.bounds.size) // create scene
        scene.scaleMode = .AspectFill // resize scene to file the screen
        
        let skView = view as! SKView // get GameViewController's SKView
        skView.showsFPS = true // display FPS
        skView.showsNodeCount = true // display Node Count
        skView.ignoresSiblingOrder = true // for SpriteKit optimizations
        skView.presentScene(scene) // display the scene
        
        
    }

}
