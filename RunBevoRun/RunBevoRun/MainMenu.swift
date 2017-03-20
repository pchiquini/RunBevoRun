//
//  MainMenu.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/13/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit


class MainMenu: SKScene {
    
    var starfield:SKEmitterNode!
    
    var startGame:SKSpriteNode!
    var changeCharacter:SKSpriteNode!
    var characterLabel:SKLabelNode!
    
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
        
        /** Start/Loop Backgroun Music **/
        let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "MainMenu.mp3")
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        
        starfield = self.childNode(withName: "starfield") as! SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        startGame = self.childNode(withName: "startGameButton") as! SKSpriteNode
        changeCharacter = self.childNode(withName: "changeCharacterButton") as! SKSpriteNode
        
        startGame.texture = SKTexture(imageNamed: "startGameButton")
        changeCharacter.texture = SKTexture(imageNamed: "changeCharacterButton")
        
        characterLabel = self.childNode(withName: "characterLabel") as! SKLabelNode
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "Running as Bevo") {
            characterLabel.text = "Running as Bevo"
        }else{
            characterLabel.text = "Running as HookEm"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "startGameButton" {
                
                    if let scene = GameScene(fileNamed: "GameScene") {
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                }
            }
                    
            else if atPoint(location).name == "changeCharacterButton" {
                        
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFit
                            
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                }
                        
            else if atPoint(location).name == "question" {
                        
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFit
                            
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                    
                    }
                }
            }
        }
    }
    
    func changeDifficulty(){
        
        let userDefaults = UserDefaults.standard
        
        if characterLabel.text == "Running as Bevo" {
            characterLabel.text = "Running as Hookem"
            userDefaults.set(true, forKey: "Running as Hookem")
        }else{
            characterLabel.text = "Running as Bevo"
            userDefaults.set(false, forKey: "Running as Hookem")
        }
        
        userDefaults.synchronize()
    }

}
