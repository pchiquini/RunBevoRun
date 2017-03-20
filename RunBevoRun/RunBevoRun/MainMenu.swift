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
        let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "GameScene.mp3")
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
        
        let touch = touches.first
    
        if let location = touch?.location(in: self) {
            
            let node = self.nodes(at: location)
            
            if node[0].name == "startGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view!.presentScene(gameScene, transition: transition)
            }else if node[0].name == "changeCharacterButton" {
                changeDifficulty()
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
