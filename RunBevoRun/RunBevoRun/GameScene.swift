//
//  GameScene.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/9/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /** Background Variables Used for Infinite Effect **/
    private var bg1: BackgroundClass?
    private var bg2: BackgroundClass?
    private var bg3: BackgroundClass?
    
    /** Ground Variables Used for Infinite Effect **/
    private var ground1: GroundClass?
    private var ground2: GroundClass?
    private var ground3: GroundClass?
    
    /** Bevo Variable **/
    private var bevo: Player?

    /** Main Camera **/
    private var mainCamera: SKCameraNode?
    
    
    /***    Variable For GameScene1 ***/
    var enemy:SKSpriteNode?
    var item:SKSpriteNode?

    var platform1:SKSpriteNode?
    
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    var death = Bool()
    
    var scoreLabel:SKLabelNode?
    var score:Int = 0
    
    /***    Bitmasks  ***/
//    let noCategory:UInt32 = 0               //places with no physical colissions to take place
//    let platformsCategory:UInt32 = 0b1
//    let playerCategory:UInt32 = 0b1 << 1
//    let enemyCategory:UInt32 = 0b1 << 2
//    let itemCategory:UInt32 = 0b1 << 3
//    static let Score : UInt32 = 0x1 << 4

    
    func createScene(){
        
        /**Initializing Camera for the Game**/
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode!
        
        /**Creating Infinite Background and Ground Variables**/
        bg1 = childNode(withName: "background1") as? BackgroundClass!
        bg2 = childNode(withName: "background2") as? BackgroundClass!
        bg3 = childNode(withName: "background3") as? BackgroundClass!
        
        ground1 = childNode(withName: "ground1") as? GroundClass!
        ground2 = childNode(withName: "ground2") as? GroundClass!
        ground3 = childNode(withName: "ground3") as? GroundClass!
        
        /*** Intianliaze Ground ***/
        ground1?.initGround()
        ground2?.initGround()
        ground3?.initGround()
        
        //this is settings for the physics world. It will handle collisions
        self.physicsWorld.contactDelegate = self
        
        /*** Intianliaze Bevo from the Player class for the GameScence ***/
        bevo = self.childNode(withName: "bevo") as? Player!
        bevo?.initPlayer()
        
        //item = self.childNode(withName: "item") as? SKSpriteNode
        enemy = self.childNode(withName: "test") as? SKSpriteNode
        
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
        
//        /***    Collision and Contact Masks   ***/
//        bevo?.physicsBody?.categoryBitMask = playerCategory  //bevo is in the player Category
//        bevo?.physicsBody?.contactTestBitMask = enemyCategory | itemCategory //we keep track of contact with others
        
//        item?.physicsBody?.categoryBitMask = itemCategory
//        item?.physicsBody?.collisionBitMask = noCategory        //item does not cause any physical collisions with other objects
//        item?.physicsBody?.contactTestBitMask = playerCategory
//        
//        enemy?.physicsBody?.categoryBitMask = enemyCategory
//        enemy?.physicsBody?.collisionBitMask = noCategory       //item does not cause any physical collisions with other objects
//        enemy?.physicsBody?.contactTestBitMask = playerCategory
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
//        //identify which category each object is in
//        let cA:UInt32 = contact.bodyA.categoryBitMask
//        let cB:UInt32 = contact.bodyB.categoryBitMask
//        
//        //checking for the playerCategory (bevo)
//        if cA == playerCategory || cB == playerCategory {
//            //otherNode represents the non-bevo object
//            let otherNode:SKNode = (cA == playerCategory) ? contact.bodyB.node! : contact.bodyA.node!
//            playerDidCollide(with: otherNode)
//        }
//        else{
//            //if contact happens between the item and the enemy, remove them both?
//            contact.bodyA.node?.removeFromParent()
//            contact.bodyB.node?.removeFromParent()
//        }
    }
    
    func playerDidCollide(with other:SKNode){

//        /** Handling Multiples Calls to PlayerDid Collide**/
//        if other.parent == nil{
//            return
//        }
//        
//        let otherCategory = other.physicsBody?.categoryBitMask
//        
//        if otherCategory == itemCategory {
//            /*** Gathering Points ***/
//            let points:Int = other.userData?.value(forKey: "points") as! Int
//            score += points
//            scoreLabel?.text = "Score: \(score)"
//            
//            other.removeFromParent()
//        }
//        else if otherCategory == enemyCategory {
//            
//            let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
//            //explosion.position = contact.bodyA.node!.position
//            explosion.position = (bevo?.position)!
//            
//            self.addChild(explosion)
//            other.removeFromParent()
//            bevo?.removeFromParent()
//        }
        
        
    }
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func addItem() {
     
    }
    
    
    func createPlatforms(){
//    
//        wallPair = SKNode()
//        wallPair.name = "wallPair"
//        let platform1 = SKSpriteNode(imageNamed: "platform1")
//        
//        platform1.position = CGPoint(x: self.frame.width, y: self.frame.midY + 550)
//        
//        platform1.setScale(0.7)
//        
//        platform1.physicsBody = SKPhysicsBody(rectangleOf: platform1.size)
//        platform1.physicsBody?.categoryBitMask = platformsCategory
//        //platform1.physicsBody?.collisionBitMask = PhysicsCatagory.Ghost
//        platform1.physicsBody?.isDynamic = false
//        platform1.physicsBody?.affectedByGravity = false
//        
//        platform1.zRotation  = CGFloat(M_PI)
//
//        wallPair.addChild(platform1)
//        wallPair.zPosition = 5
//        
//        var randomPosition = CGFloat.random(min: -250, max: 250)
//        wallPair.position.y = wallPair.position.y + randomPosition
//        //wallPair.addChild(scoreNode)
//        wallPair.run(moveAndRemove)
//        self.addChild(wallPair)
    }
    
//    func createPlatform(){
//        
//        let scene:SKScene = SKScene(fileNamed: "platform1")!
//        //let platform1 = scene.childNode(withName: "platform1")
//        platform1?.physicsBody?.categoryBitMask = platformsCategory
//        platform1?.physicsBody?.contactTestBitMask = playerCategory
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    private func manageCamera(){
        self.mainCamera?.position.x += 10
    }
    
    private func runBevorun(){
        self.bevo?.position.x += 10
    }
    
    /** Managing Backgrounds and Grounds **/
    private func manageBGsAndGrounds(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
        
        ground1?.moveGrounds(camera: mainCamera!)
        ground2?.moveGrounds(camera: mainCamera!)
        ground3?.moveGrounds(camera: mainCamera!)
    }
        
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
       // manageCamera()
       // manageBGsAndGrounds()
        runBevorun()
        
        //Apply forces

        
        //Apply animiations

    }
}
