//
//  Blocker.swift
//  Cannon
//
//  Created by Admin on 4/28/16.
//  Copyright © 2016 Morra. All rights reserved.
//

// Defines a blocker
import AVFoundation
import SpriteKit

enum BlockerSize: CGFloat {
    case Small = 1.0
    case Medium = 2.0
    case Large = 3.0
}

class Blocker: SKSpriteNode {
    
    // constants for configuring a blocker
    private let blockerWidthPercent = CGFloat(0.025)
    private let blockerHeightPercent = CGFloat(0.125)
    private let blockerSpeed = CGFloat(5.0)
    private let blockerSize: BlockerSize
    
    
    init(sceneSize: CGSize, blockerSize: BlockerSize) {
        
        self.blockerSize = blockerSize
        
        super.init(
            texture: SKTexture(imageNamed: "blocker"),
            color: UIColor.clearColor(),
            size: CGSizeMake(sceneSize.width * blockerWidthPercent, sceneSize.height * blockerHeightPercent * blockerSize.rawValue)
        )
        
        
        // set up the blocker's physicsBody
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.friction = 0.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Blocker
        self.physicsBody?.contactTestBitMask = CollisionCategory.Cannonball
        
        
    }
    
    // not called, but required if subclass defines an init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // applies an impulse to the blocker
    func startMoving(velocityMultiplier: CGFloat) {
        self.physicsBody?.applyImpulse(CGVectorMake(0.0,
            velocityMultiplier * blockerSpeed * blockerSize.rawValue))
    }
    
    // plays the blockerHitSound
    func playHitSound() {
        blockerHitSound.play()
        
    }
    
    // returns time penalty based on blocker size
    func blockerTimePenalty() -> CFTimeInterval {
        
        return CFTimeInterval(BlockerSize.Small.rawValue)
        
    }
    
}
