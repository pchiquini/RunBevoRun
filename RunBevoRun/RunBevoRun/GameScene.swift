//
//  GameScene.swift
//  RunplayerRun
//
//  Created by Patrizio Chiquini on 3/9/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameData {
    static let sharedInstance = GameData()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /********************************************************************/
    /*                                                                  */
    /*                        GAME VARIABLES                            */
    /*                                                                  */
    /********************************************************************/
    
    /** Main Camera **/
    private var mainCamera: SKCameraNode?
    
    /** Start/Loop Backgroun Music **/
    //let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "GameScene.mp3")
    
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
    
    /** Player Lives **/
    var life1: SKSpriteNode?
    var life2: SKSpriteNode?
    var life3: SKSpriteNode?
    var totalLives:Int = 3
    
    /** Back Wall Variable **/
    private var backWall: PlatformClass?
    
    /** Scoring **/
    var scoreLabel: SKLabelNode?
    
    /** Declaring Objects from according Class**/
    private var itemController = ItemClass()
    private var platformController = PlatformClass()
    
    /** Starting Point **/
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
        
        /** Initializing Timer **/
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(GameScene.timeIsOut), userInfo: true, repeats: false)
        
        /** Settings For Physics World **/
        self.physicsWorld.contactDelegate = self
        
        /** Start/Loop Backgroun Music **/
        ////let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "GameScene.mp3")
        //backgroundMusic.autoplayLooped = true
        //self.addChild(backgroundMusic)
        
        /** Creating Infinite Background and Ground Variables **/
        bg1 = childNode(withName: "background1") as? BackgroundClass!
        bg2 = childNode(withName: "background2") as? BackgroundClass!
        bg3 = childNode(withName: "background3") as? BackgroundClass!
        
        ground1 = childNode(withName: "ground1") as? GroundClass!
        ground2 = childNode(withName: "ground2") as? GroundClass!
        ground3 = childNode(withName: "ground3") as? GroundClass!
        
        /** Intianliaze Ground **/
        ground1?.initGround()
        ground2?.initGround()
        ground3?.initGround()

        /** Intianliaze player from the Player class for the GameScence **/
        player = self.childNode(withName: "player") as? Player!
        //player = SKSpriteNode(imageNamed:"player8") as? Player!
        player?.initPlayer()
        
        /** Creating the Player's lives **/
        life1 = mainCamera!.childNode(withName: "life1") as? SKSpriteNode!
        life2 = mainCamera!.childNode(withName: "life2") as? SKSpriteNode!
        life3 = mainCamera!.childNode(withName: "life3") as? SKSpriteNode!
        
        /** Intianliaze the BackWall for the GameScence **/
        backWall = self.childNode(withName: "backWall") as? PlatformClass!
        backWall?.initBackWall()
        
        /** Intianliaze Running Score Label **/
        scoreLabel = mainCamera!.childNode(withName: "scoreLabel") as? SKLabelNode!
        UserInfo.shared.score = 0
        scoreLabel?.text = "0"
        
        /** Intianliaze the timer used for Spawning Objects on the GameScence **/
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomNumber(firstNum: 1, secondNum: 4)), target: self, selector: #selector(GameScene2.addItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(platformController.randomNumber(firstNum: 1, secondNum: 4)), target: self, selector: #selector(GameScene2.addPlatforms), userInfo: nil, repeats: true)
        
        /** Collision and Contact Masks **/
        ground1?.physicsBody?.categoryBitMask = ColliderType.GROUND
        ground1?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        ground2?.physicsBody?.categoryBitMask = ColliderType.GROUND
        ground2?.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        ground3?.physicsBody?.categoryBitMask = ColliderType.GROUND
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
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
            
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        /** Gathers Points **/
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Item" {
            
            /** Adds Points Sound Effect: Texas **/
            self.run(SKAction.playSoundFileNamed("points.mp3", waitForCompletion: false))
            
            /** Updates Score **/
            UserInfo.shared.score += 1
            scoreLabel!.text = String(UserInfo.shared.score)
            
            /** Removes Nodes **/
            secondBody.node?.removeFromParent()
            
            /** How To Win The Game: Must Collect 5 Longhorns **/
//            if(UserInfo.shared.score >= 5){
//                if let scene = LevelCompleted(fileNamed: "LevelCompleted") {
//                    scene.scaleMode = .aspectFit
//                    
//                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
//                }
//            }
        }
        
        /** Subtracts Score & Explodes **/
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Enemy" {
           
            /** Total Lives Equation **/
            totalLives += -1
            
            /** Updates Score Equation **/
            UserInfo.shared.score += -1
            scoreLabel?.text = String(UserInfo.shared.score)
            
            if totalLives == 2 {
                /** Remove Life and Enemy Collison **/
                life1?.removeFromParent()
                secondBody.node?.removeFromParent()
            }
                
            else if totalLives == 1 {
                /** Remove Life and Enemy Collison **/
                life2?.removeFromParent()
                secondBody.node?.removeFromParent()
            }
            
            else if totalLives == 0 {
                /** Remove Life **/
                life3?.removeFromParent()
                
                /** Removes Nodes **/
                secondBody.node?.removeFromParent()
                firstBody.node?.removeFromParent()
                
                /** Adds Special Effect: Explosion **/
                explosion()
                
                /** Intianliaze the timer used for restaring the GameScence **/
                self.run(SKAction.wait(forDuration: 2)) {
                    self.gameOver()
                }
            }
            
            /*** Intianliaze the timer used for restaring the GameScence ***/
//            Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(GameScene.restartGame), userInfo: nil, repeats: false)
            
        }
        
        /** Player Goes Off The Screen **/
        if firstBody.node?.name == "Player" && secondBody.node?.name == "BackWall" {
            
            /** Removes Nodes **/
            secondBody.node?.removeFromParent()
            firstBody.node?.removeFromParent()
            
            /** Adds Special Effect: Explosion **/
            explosion()
            
            /** Intianliaze the timer used for restaring the GameScence **/
            self.run(SKAction.wait(forDuration: 2)) {
                self.gameOver()
            }
        }

    }
    
    /********************************************************************/
    /*                                                                  */
    /*                        DURING GAMEPLAY                           */
    /*                                                                  */
    /********************************************************************/
    
    
    /** Handles Bevo Jumping **/
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /** Adds Points Sound Effect: jumping **/
        //self.run(SKAction.playSoundFileNamed("jumping.mp3", waitForCompletion: false))
        player?.jump()
    }
    
    /** Handles the camera's position **/
    private func manageCamera(){
        self.mainCamera?.position.x += 10
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
    
    /** Spawns Items onto the GameScene **/
    func addItems(){
       self.scene?.addChild(itemController.spawnItems(camera: mainCamera!))
    }
    
    /** Spawns Platforms onto the GameScene **/
    func addPlatforms(){
        self.scene?.addChild(platformController.spawnPlatforms(camera: mainCamera!))
    }
    
    /** Moves Enemy on the GameScene **/
    func moveEnemy(){
        enumerateChildNodes(withName: "enemy", using:({
            (node, error) in
            node.position.x -= 5
        }))
    }
    
    func explosion(){
        /** Adds Special Effect: Explosion **/
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = (player?.position)!
        self.addChild(explosion)
        
        /** Adds Explosion Sound Effect: Explosion **/
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
    }
    
    /** Time Is Out, transition into the Trivia **/
    func timeIsOut(){
        if let scene = Trivia(fileNamed: "Trivia") {
            scene.scaleMode = .aspectFit
            
            view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
        }
    }
    
    func gameOver(){
        
        //backgroundMusic.run(SKAction.stop())
                
        /** Intianliaze the timer used for restaring the GameScence **/
        if let scene = GameOver(fileNamed: "GameOver") {
            scene.scaleMode = .aspectFit
            
            view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
        }
    }
    
    /** Called before each frame is rendered **/
    override func update(_ currentTime: TimeInterval) {
        manageCamera()
        manageBGsAndGrounds()
        player?.move()
        backWall?.backWallMove()
        moveEnemy()
    }
}
