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
    var backButton:SKSpriteNode!
    
    /** Start/Loop Backgroun Music **/
    //let sound:SKAction = SKAction.playSoundFileNamed("MainMenu.mp3", waitForCompletion: false)
    //let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "MainMenu.mp3")
    
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
        
        /** Starts Backgroun Music **/
        //if (UserInfo.shared.onMainMenu == 1) {
            /** Start/Loop Backgroun Music **/
            //addChild(backgroundMusic)
            //UserInfo.shared.onMainMenu = 0
        //}

        /** Adding the buttons to the Screen **/
        startGame = self.childNode(withName: "startGameButton") as! SKSpriteNode
        changeCharacter = self.childNode(withName: "changeCharacterButton") as! SKSpriteNode
        characterLabel = self.childNode(withName: "characterLabel") as! SKLabelNode
        backButton = self.childNode(withName: "backButton") as! SKSpriteNode

        
        if (UserInfo.shared.character == 1) {
            characterLabel.text = "Running as Bevo"
        }
        else if (UserInfo.shared.character == 2) {
            characterLabel.text = "Running as HookEm"
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {

            let location = touch.location(in: self)
            
            if atPoint(location).name == "startGameButton" {
                
                /** Stop Playing MainMenu Music **/
                //backgroundMusic.run(SKAction.stop())
                //UserInfo.shared.onMainMenu = 1
                
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
            
            /** Log Out Button: Not Implemented **/
            else if atPoint(location).name == "backButton" {
                
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}
