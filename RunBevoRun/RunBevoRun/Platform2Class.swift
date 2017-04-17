//
//  Platform2Class.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 4/15/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

/********************************************************************/
/*                                                                  */
/*                        PLATFORMS: SCENE 2                        */
/*                                                                  */
/********************************************************************/

class Platform2Class: SKSpriteNode {
    
    private var minY = CGFloat(-60.0)
    private var maxY = CGFloat(150.0)
    
    var platform: SKSpriteNode?
    
    func spawnPlatforms(camera: SKCameraNode) -> SKSpriteNode {
        
        /* Identifying the qualities of a Platform */
        platform = SKSpriteNode(imageNamed: "platform2")
        platform?.name = "Platform"
        platform?.size = CGSize(width: 150, height: 50)
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
}
