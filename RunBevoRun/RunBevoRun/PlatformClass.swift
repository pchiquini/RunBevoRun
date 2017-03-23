//
//  PlatformClass.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/16/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

class PlatformClass: SKSpriteNode {
    
    private var minY = CGFloat(-118.0)
    private var maxY = CGFloat(150.0)
    
    var platform: SKSpriteNode?
    
    func spawnPlatforms(camera: SKCameraNode) -> SKSpriteNode {
        
        /* Identifying the qualities of a Platform */
        platform = SKSpriteNode(imageNamed: "platform1")
        platform?.name = "Platform"
        platform?.size = CGSize(width: 120, height: 60)
        platform?.setScale(0.7)
        platform?.physicsBody = SKPhysicsBody(rectangleOf: platform!.size)
        platform!.physicsBody?.affectedByGravity = false
        platform?.physicsBody?.isDynamic = false
        platform?.zPosition = 3
        platform?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        /* Collision and Contact Masks */
        platform?.physicsBody?.categoryBitMask = ColliderType.GROUND
        platform?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        
        /* Use Camera's position to Spawn Items */
        platform?.position.x = camera.position.x + 900
        platform?.position.y = randomNumber(firstNum: minY, secondNum: maxY)
        
        return platform!
    }
    
    /* Generate Random Number for Positioning */
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func initBackWall(){
    
        /* Helps with Collisions */
        name = "BackWall"
        
        /* Coding/Setting Some Properties of Player */
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 10))
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        
        /*   Collision and Contact Masks   */
        physicsBody?.categoryBitMask = ColliderType.GROUND
        physicsBody?.contactTestBitMask = ColliderType.PLAYER
    }
    
    /* Handles BackWall Automatic Movement */
    func backWallMove(){
        self.position.x += 10
    }

}





    
