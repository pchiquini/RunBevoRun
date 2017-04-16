//
//  Item2Class.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 4/15/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

class Item2Class: SKSpriteNode {
    
    private var minY = CGFloat(-118.0)
    private var maxY = CGFloat(150.0)
    
    /* Variables for Enemies Animations */
    var item:SKSpriteNode?
    private var enemyAnimation = [SKTexture]()
    private var animateEnemyAction = SKAction()
    
    func spawnItems(camera: SKCameraNode) -> SKSpriteNode {
        
        /* Identifying wether the Item is an enemy/item */
        if Int(randomNumber(firstNum: 1, secondNum: 10)) >= 6 {
            item = SKSpriteNode(imageNamed: "item")
            item?.name = "Item"
            item?.size = CGSize(width: 92, height: 46)
            item?.setScale(0.7)
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        }
            
        else{
            item = SKSpriteNode(imageNamed: "enemy2")
            item?.name = "Enemy"
            item?.size = CGSize(width: 44, height: 49)
            item?.setScale(0.7)
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
        }
        
        item!.physicsBody?.affectedByGravity = false
        item?.physicsBody?.categoryBitMask = ColliderType.ITEM
        item?.zPosition = 3
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        /* Initialize Animations by filtering */
        for i in 0...30 {
            let name = "football\(i)"
            enemyAnimation.append(SKTexture(imageNamed: name))
        }
        
        animateEnemyAction = SKAction.animate(with: enemyAnimation, timePerFrame: 0.08, resize: false, restore: false)
        
        /* Run Animation Forever */
        self.run(SKAction.repeatForever(animateEnemyAction))
        
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
