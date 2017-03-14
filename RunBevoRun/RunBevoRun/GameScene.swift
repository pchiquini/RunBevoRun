//
//  GameScene.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/9/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCatagory{
    //option to add the collisions and bitmask here for cleaner code
    //instead of: aladdin?.physicsBody?.categoryBitMask = playerCategory
    //one would do aladdin?.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /***    Variable For GameScene1 ***/
    var aladdin:SKSpriteNode?
    var enemy:SKSpriteNode?
    var item:SKSpriteNode?

    var ground1:SKSpriteNode?
    var platform1:SKSpriteNode?
    var background:SKSpriteNode?
    
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    var death = Bool()
    
    var scoreLabel:SKLabelNode?
    var score:Int = 0
    
    /***    Bitmasks  ***/
    let noCategory:UInt32 = 0               //places with no physical colissions to take place
    let platformsCategory:UInt32 = 0b1
    let playerCategory:UInt32 = 0b1 << 1
    let enemyCategory:UInt32 = 0b1 << 2
    let itemCategory:UInt32 = 0b1 << 3
    static let Score : UInt32 = 0x1 << 4

    
    func createScene(){
        //this is settings for the physics world. It will handle collisions
        self.physicsWorld.contactDelegate = self
        
        /***    intiantiate the variables from the GameScence   ***/
        aladdin = self.childNode(withName: "aladdin") as? SKSpriteNode
        //item = self.childNode(withName: "item") as? SKSpriteNode
        enemy = self.childNode(withName: "test") as? SKSpriteNode
        
        ground1 = self.childNode(withName: "ground1") as? SKSpriteNode
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode
        background = self.childNode(withName: "background") as? SKSpriteNode
        
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
        
        /***    Collision and Contact Masks   ***/
        aladdin?.physicsBody?.categoryBitMask = playerCategory  //bevo is in the player Category
        aladdin?.physicsBody?.contactTestBitMask = enemyCategory | itemCategory //we keep track of contact with others
        
        item?.physicsBody?.categoryBitMask = itemCategory
        item?.physicsBody?.collisionBitMask = noCategory        //item does not cause any physical collisions with other objects
        item?.physicsBody?.contactTestBitMask = playerCategory
        
        enemy?.physicsBody?.categoryBitMask = enemyCategory
        enemy?.physicsBody?.collisionBitMask = noCategory       //item does not cause any physical collisions with other objects
        enemy?.physicsBody?.contactTestBitMask = playerCategory
        
        
        
        
        for i in 0..<2{
            let background = SKSpriteNode(imageNamed: "background")
            background.anchorPoint = CGPoint(x: 0.5, y:0.5)
            background.position = CGPoint(x: (CGFloat(i) * self.frame.width) , y: 0)
            background.zPosition = CGFloat(-2)
            background.name = "background"
            background.size = self.frame.size
            //background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //identify which category each object is in
        let cA:UInt32 = contact.bodyA.categoryBitMask
        let cB:UInt32 = contact.bodyB.categoryBitMask
        
        //checking for the playerCategory (bevo)
        if cA == playerCategory || cB == playerCategory {
            //otherNode represents the non-bevo object
            let otherNode:SKNode = (cA == playerCategory) ? contact.bodyB.node! : contact.bodyA.node!
            playerDidCollide(with: otherNode)
        }
        else{
            //if contact happens between the item and the enemy, remove them both?
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    func playerDidCollide(with other:SKNode){

        /** Handling Multiples Calls to PlayerDid Collide**/
        if other.parent == nil{
            return
        }
        
        let otherCategory = other.physicsBody?.categoryBitMask
        
        if otherCategory == itemCategory {
            /*** Gathering Points ***/
            let points:Int = other.userData?.value(forKey: "points") as! Int
            score += points
            scoreLabel?.text = "Score: \(score)"
            
            other.removeFromParent()
        }
        else if otherCategory == enemyCategory {
            
            let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
            //explosion.position = contact.bodyA.node!.position
            explosion.position = (aladdin?.position)!
            
            self.addChild(explosion)
            other.removeFromParent()
            aladdin?.removeFromParent()
        }
        
        
    }
    override func didMove(to view: SKView) {
        createScene()
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addItem),
                SKAction.wait(forDuration: 1.0)
                ])
        ))
    }
    
    func addItem() {
     
    }
    
    
    func createPlatforms(){
    
        wallPair = SKNode()
        wallPair.name = "wallPair"
        let platform1 = SKSpriteNode(imageNamed: "platform1")
        
        platform1.position = CGPoint(x: self.frame.width, y: self.frame.midY + 550)
        
        platform1.setScale(0.7)
        
        platform1.physicsBody = SKPhysicsBody(rectangleOf: platform1.size)
        platform1.physicsBody?.categoryBitMask = platformsCategory
        //platform1.physicsBody?.collisionBitMask = PhysicsCatagory.Ghost
        platform1.physicsBody?.isDynamic = false
        platform1.physicsBody?.affectedByGravity = false
        
        platform1.zRotation  = CGFloat(M_PI)

        wallPair.addChild(platform1)
        wallPair.zPosition = 5
        
        var randomPosition = CGFloat.random(min: -250, max: 250)
        wallPair.position.y = wallPair.position.y + randomPosition
        //wallPair.addChild(scoreNode)
        wallPair.run(moveAndRemove)
        self.addChild(wallPair)
    }
    
//    func createPlatform(){
//        
//        let scene:SKScene = SKScene(fileNamed: "platform1")!
//        //let platform1 = scene.childNode(withName: "platform1")
//        platform1?.physicsBody?.categoryBitMask = platformsCategory
//        platform1?.physicsBody?.contactTestBitMask = playerCategory
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if gameStarted == false{
            gameStarted = true
            aladdin?.physicsBody?.affectedByGravity = true

            let spawn = SKAction.run({
                () in
                self.createPlatforms()
            })
        
        let delay = SKAction.wait(forDuration: 2.0)
        let SpawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
        self.run(spawnDelayForever)
        
        
        let distance = CGFloat(self.frame.width*2)
        
        let movePipes = SKAction.moveBy(x: -distance - 200, y: 0, duration: TimeInterval(0.006 * distance))
        let removePipes = SKAction.removeFromParent() //remove the pipes after they moved off the screen
        
        moveAndRemove = SKAction.sequence([movePipes, removePipes])
        
        aladdin?.physicsBody?.velocity = CGVector(dx: 0.0 , dy: 0.0)
        aladdin?.physicsBody?.applyImpulse(CGVector(dx: 0.0 , dy: 10.0), at: (aladdin?.position)!)
        platform1?.physicsBody?.velocity = CGVector(dx: 10.0, dy: 0.0)
        
        }else{
            if death == true{
                
            }else{
                aladdin?.physicsBody?.velocity = CGVector(dx: 0.0 , dy: 0.0)
                aladdin?.physicsBody?.applyImpulse(CGVector(dx: 0.0 , dy: 10.0), at: (aladdin?.position)!)
            }
        }
    }
        
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Apply forces

        
        //Apply animiations
        
        
        /*** Background Autorotates ***/
        enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            
            var bg = node as! SKSpriteNode
            bg.position = CGPoint(x: bg.position.x - 3, y: bg.position.y)
            //point and float
            if bg.position.x <= -bg.size.width{
                bg.position = CGPoint(x: bg.position.x + bg.size.width*2, y: bg.position.y)
            }
        }))
    }
}
