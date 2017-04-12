//
//  Player.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER:UInt32 = 0    //playerCategory
    static let GROUND:UInt32 = 1    //groundCategory
    static let ENEMY:UInt32 = 2     //enemyCategory
    static let ITEM:UInt32 = 3      //itemCategory
    static let PLATFORM:UInt = 4    //platform Category
}

class Player: SKSpriteNode {
    
    /* Variables for Bevo Animations */
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    /* Initialize Player and its Animation */
    func initPlayer(){
        
        /* Helps with Collisions */
        name = "Player"
        
        /* Initialize Animations by filtering */
        for i in 0...30 {
            let name = "bevo\(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: false, restore: false)
        
        /* Run Animation Forever */
        self.run(SKAction.repeatForever(animatePlayerAction))
        
        /* Coding/Setting Some Properties of Player */
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 10, height: self.size.height - 13))
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        
        /* Collision and Contact Masks */
        physicsBody?.categoryBitMask = ColliderType.PLAYER //bevo is in the player Category
        physicsBody?.contactTestBitMask = ColliderType.ENEMY | ColliderType.ITEM  //track of contact with others
        physicsBody?.collisionBitMask = ColliderType.GROUND
    }
    
    /* Handles Bevo Automatic Movement */
    func move(){
        self.position.x += 10
    }
    
    /* Handles Bevo Jumping */
    func jump(){
        if self.action(forKey: "jump") == nil { // check that there's no jump action running
            let jumpUp = SKAction.moveBy(x: 30, y: 250, duration: 0.2)
            let fallBack = SKAction.moveBy(x: -5, y: -10, duration: 0.3)
            self.run(SKAction.sequence([jumpUp, fallBack]), withKey:"jump")
        }
    }
}

