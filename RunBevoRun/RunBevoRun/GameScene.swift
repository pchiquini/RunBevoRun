//
//  GameScene.swift
//  RunplayerRun
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
    
    /** player Variable **/
    private var player: Player?
    
    /** Main Camera **/
    private var mainCamera: SKCameraNode?
    
    /** Declaring Item from its Class**/
    //private var itemController = ItemClass()
    
    /***    Variable For GameScene1 ***/
    var enemy:SKSpriteNode?
    
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
        
        /*** Intianliaze player from the Player class for the GameScence ***/
        player = self.childNode(withName: "player") as? Player!
        player?.initPlayer()
        
        /*** Intianliaze the timer used for Spawning Objects on the GameScence ***/
//        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomNumber(firstNum: 1, secondNum: 3)), target: self, selector: #selector(GameScene.addItems), userInfo: nil, repeats: true)
        
        enemy = self.childNode(withName: "test") as? SKSpriteNode
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
        
        //        /***    Collision and Contact Masks   ***/
        //        player?.physicsBody?.categoryBitMask = playerCategory  //player is in the player Category
        //        player?.physicsBody?.contactTestBitMask = enemyCategory | itemCategory //we keep track of contact with others
        
        //        item?.physicsBody?.categoryBitMask = itemCategory
        //        item?.physicsBody?.collisionBitMask = noCategory        //item does not cause any physical collisions with other objects
        //        item?.physicsBody?.contactTestBitMask = playerCategory
        //
        //        enemy?.physicsBody?.categoryBitMask = enemyCategory
        //        enemy?.physicsBody?.collisionBitMask = noCategory       //item does not cause any physical collisions with other objects
        //        enemy?.physicsBody?.contactTestBitMask = playerCategory
        
        ground1?.physicsBody?.categoryBitMask = ColliderType.GROUND //gound bitmask set
        ground1?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        ground2?.physicsBody?.categoryBitMask = ColliderType.GROUND //gound bitmask set
        ground2?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        ground3?.physicsBody?.categoryBitMask = ColliderType.GROUND //gound bitmask set
        ground3?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //identify which category each object is in
        let cA:UInt32 = contact.bodyA.categoryBitMask
        let cB:UInt32 = contact.bodyB.categoryBitMask
        
        //checking for the playerCategory (player)
        if cA == ColliderType.PLAYER || cB == ColliderType.PLAYER {
            //otherNode represents the non-player object
            let otherNode:SKNode = (cA == ColliderType.PLAYER) ? contact.bodyB.node! : contact.bodyA.node!
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
        
        if otherCategory == ColliderType.ITEM {
            /*** Gathering Points ***/
            let points:Int = other.userData?.value(forKey: "points") as! Int
            score += points
            scoreLabel?.text = "Score: \(score)"
            
            other.removeFromParent()
        }
        else if otherCategory == ColliderType.ENEMY {
            
            let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
            //explosion.position = contact.bodyA.node!.position
            explosion.position = (player?.position)!
            
            self.addChild(explosion)
            other.removeFromParent()
            player?.removeFromParent()
        }
        
        
    }
    override func didMove(to view: SKView) {
        createScene()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /** Handles Bevo Jumping **/
        player?.jump()
    }
    
    
    private func manageCamera(){
        self.mainCamera?.position.x += 10
    }
    
    /** Making Bevo Run (option 2) **/
    //    private func runplayerrun(){
    //        self.player?.position.x += 10
    //    }
    
    /** Managing Backgrounds and Grounds **/
    private func manageBGsAndGrounds(){
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
        
        ground1?.moveGrounds(camera: mainCamera!)
        ground2?.moveGrounds(camera: mainCamera!)
        ground3?.moveGrounds(camera: mainCamera!)
    }
    
    /** Spawns Items onto the GameScene **/
    func addItems(){
       // self.scene?.addChild(itemController.spawnItems(camera: mainCamera!))
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        manageCamera()
        manageBGsAndGrounds()
        player?.move()
        
        //runplayerrun()
        
        //Apply forces
        
        
        //Apply animiations
        
    }
}
