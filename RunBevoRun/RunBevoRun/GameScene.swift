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
    
    /********************************************************************/
    /*                                                                  */
    /*                        GAME VARIABLES                            */
    /*                                                                  */
    /********************************************************************/
    
    /** Background Variables Used for Infinite Effect **/
    private var bg1: BackgroundClass?
    private var bg2: BackgroundClass?
    private var bg3: BackgroundClass?
    
    /** Ground Variables Used for Infinite Effect **/
    private var ground1: GroundClass?
    private var ground2: GroundClass?
    private var ground3: GroundClass?
    
    /** Player Variable **/
    private var player: Player?
    
    /** Main Camera **/
    private var mainCamera: SKCameraNode?
    
    /** Scoring **/
    var scoreLabel: SKLabelNode?
    var score:Int = 0
    
    /** Declaring Objects from according Class**/
    private var itemController = ItemClass()
    private var platformController = PlatformClass()
    
    /*** Starting Point ***/
    override func didMove(to view: SKView) {
        createScene()
        
    }
    
    /********************************************************************/
    /*                                                                  */
    /*                        CREATING THE SCENCE                       */
    /*                                                                  */
    /********************************************************************/
    
    func createScene(){
        
        /** Initializing Camera for the Game **/
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode!
        
        /** Start/Loop Backgroun Music **/
        let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "GameScene.mp3")
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        
        /** Creating Infinite Background and Ground Variables **/
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
        
        /*** Intianliaze Running Score Label ***/
        scoreLabel = mainCamera!.childNode(withName: "scoreLabel") as? SKLabelNode!
        scoreLabel?.text = "0"
        
        /*** Intianliaze the timer used for Spawning Objects on the GameScence ***/
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomNumber(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameScene.addItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(platformController.randomNumber(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameScene.addPlatforms), userInfo: nil, repeats: true)
        
        ground1?.physicsBody?.categoryBitMask = ColliderType.GROUND //gound bitmask set
        ground1?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        ground2?.physicsBody?.categoryBitMask = ColliderType.GROUND //gound bitmask set
        ground2?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        ground3?.physicsBody?.categoryBitMask = ColliderType.GROUND //gound bitmask set
        ground3?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        
    }
    
    /********************************************************************/
    /*                                                                  */
    /*                        MAKING CONTACT                            */
    /*                                                                  */
    /********************************************************************/
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        /** identify which category each object is in **/
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        /** checking for the playerCategory (player) **/
        if contact.bodyA.node?.name == "Player"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        /*** Gathers Points ***/
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Item" {
            
            /** Adds Points Sound Effect: Texas **/
            self.run(SKAction.playSoundFileNamed("points.mp3", waitForCompletion: false))
            
            /** Adds Explosion Sound Effect: Fight **/
            //self.run(SKAction.playSoundFileNamed(" ", waitForCompletion: false))
            
            score += 1
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        /*** Subtracts Score & Explodes ***/
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Enemy" {
           
            /** Adds Special Effect: Explosion **/
            let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
            explosion.position = (player?.position)!
            self.addChild(explosion)
            
            /** Adds Explosion Sound Effect: Explosion **/
            self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
            
            score += -1
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
            firstBody.node?.removeFromParent()
            
            /*** Intianliaze the timer used for restaring the GameScence ***/
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameScene.restartGame), userInfo: nil, repeats: false)
            
        }
    }
    
    /** Handles Bevo Jumping **/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /** Adds Points Sound Effect: jumping **/
        self.run(SKAction.playSoundFileNamed("jumping.mp3", waitForCompletion: false))
        player?.jump()
    }
    
    /** Handles the camera's position **/
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
       self.scene?.addChild(itemController.spawnItems(camera: mainCamera!))
    }
    
    /** Spawns Platforms onto the GameScene **/
    func addPlatforms(){
        self.scene?.addChild(platformController.spawnPlatforms(camera: mainCamera!))
    }
    
    func moveEnemy(){
        enumerateChildNodes(withName: "enemy", using:({
            (node, error) in
            node.position.x -= 5
        }))
    }
    
    func restartGame() {
        if let scene = GameScene(fileNamed: "GameScene"){
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            // Present the scene
            view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
        }
    }
    
    /** Called before each frame is rendered **/
    override func update(_ currentTime: TimeInterval) {

        manageCamera()
        manageBGsAndGrounds()
        player?.move()
        moveEnemy()
        
    }
}
