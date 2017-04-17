//
//  MainMenu.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/13/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit

struct globalVariables{}

class MainMenu: SKScene {
    
    /*** Buttons On Scene ***/
    var startGame:SKSpriteNode!
    var changeCharacter:SKSpriteNode!
    var characterLabel:SKLabelNode!
    
    let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "MainMenu.mp3")
    //var isMusicPlaying:Bool?
    
    let sound:SKAction = SKAction.playSoundFileNamed("MainMenu", waitForCompletion: true)
   
    
    /*** Starting Point ***/
    override func didMove(to view: SKView) {
        createScene()
        
    }
    
    /********************************************************************/
    /*                                                                  */
    /*                        CREATING THE SCENCE                       */
    /*                                                                  */
    /********************************************************************/
    
    func createScene() {
        
        /* Reseting the Number of the Scene */
        UserInfo.shared.currentScene = 1
        
        if(UserInfo.shared.userOnMainMenu == true){
            //self.addChild(backgroundMusic)
            //let loopSound:SKAction = SKAction.repeatForever(sound)
            //self.run(loopSound)
        }
        
        /** Start/Loop Backgroun Music **/
        //        if(isMusicPlaying == false )//|| isMusicPlaying == nil)
        //        {
        //            print("\(isMusicPlaying)")
        //            self.run(SKAction.playSoundFileNamed("MainMenu.mp3", waitForCompletion: false))
        //            isMusicPlaying = true
        //            print("\(isMusicPlaying)")
        //        }
        
        /** Adding the buttons to the Screen **/
        startGame = self.childNode(withName: "startGameButton") as! SKSpriteNode
        changeCharacter = self.childNode(withName: "changeCharacterButton") as! SKSpriteNode
        characterLabel = self.childNode(withName: "characterLabel") as! SKLabelNode
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "Running as Bevo") {
            
            characterLabel.text = "Running as HookEm"
        }
            
        else{
            
            characterLabel.text = "Running as Bevo"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "startGameButton" {
                
                    /** Stop Playing MainMenu Music **/
                    backgroundMusic.run(SKAction.stop())
                
                    if let scene = GameScene(fileNamed: "GameScene1") {
                        
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                }
            }
                    
            else if atPoint(location).name == "changeCharacterButton" {
                        
                if let scene = ChangeCharacter(fileNamed: "ChangeCharacter") {
                    
                    scene.scaleMode = .aspectFit
                            
                        view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))                }
            }
                
            else if atPoint(location).name == "howToPlay" {
                        
                if let scene = GameRules(fileNamed: "GameRules") {
                    
                    scene.scaleMode = .aspectFit
                            
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
                }
            }
        }
    }
}
