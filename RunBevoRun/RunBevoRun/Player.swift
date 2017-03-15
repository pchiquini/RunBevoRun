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
}

class Player: SKSpriteNode {
    
    /** Variables for Bevo Animations **/
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    /** Initialize Player and its Animation **/
    func initPlayer(){
        
//        /* Helps with Collisions */
//        name = "Player"
//        
//        /** Initialize Animations by filtering **/
//        for i in 1...6 {
//            let name = "Player \(i)"
//            playerAnimation.append(SKTexture(imageNamed: name))
//        }
//        
//        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
//        
//        /* Run Animation Forever */
//        self.run(SKAction.repeatForever(animatePlayerAction))
        
        /* Coding/Setting Some Properties of Player */
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 10))
        physicsBody?.affectedByGravity = true;
        
        /***    Collision and Contact Masks   ***/
        physicsBody?.categoryBitMask = ColliderType.PLAYER   //playerCategory  //bevo is in the player Category
        physicsBody?.contactTestBitMask = ColliderType.ENEMY | ColliderType.ITEM //enemyCategory | itemCategory //we keep track of contact with others
        physicsBody?.collisionBitMask = ColliderType.GROUND
    }
    
    func move(){
        self.position.x += 10
    }
}
































