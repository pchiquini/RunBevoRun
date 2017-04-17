//
//  Item2Class.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 4/15/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

/********************************************************************/
/*                                                                  */
/*                        ITEMS: SCENE 2                            */
/*                                                                  */
/********************************************************************/

class Item2Class: SKSpriteNode {
    
    private var minY = CGFloat(-100.0)
    private var maxY = CGFloat(150.0)
    
    var item:SKSpriteNode?
    
    func spawnItems(camera: SKCameraNode) -> SKSpriteNode {
        
        /* Identifying wether the Item is an enemy/item */
        if Int(randomNumber(firstNum: 1, secondNum: 10)) >= 5 {
            item = SKSpriteNode(imageNamed: "item")
            item?.name = "Item"
            item?.size = CGSize(width: 98, height: 52)
            item?.setScale(0.7)
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        }
            
        else{
            item = SKSpriteNode(imageNamed: "enemy2")
            item?.name = "Enemy"
            item?.size = CGSize(width: 45, height: 45)
            item?.setScale(0.7)
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        }
        
        item!.physicsBody?.affectedByGravity = false
        item?.physicsBody?.categoryBitMask = ColliderType.ITEM
        item?.zPosition = 3
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        /* Use Camera's position to Spawn Items */
        item?.position.x = camera.position.x + 900
        item?.position.y = randomNumber(firstNum: minY, secondNum: maxY)
        
        return item!
    }
    
    /* Generate Random Number for Positioning */
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
