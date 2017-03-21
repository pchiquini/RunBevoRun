//
//  GameOver.swift
//  RunBevoRun
//
//  Created by Chiquini, Patrizio on 3/21/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit

class GameOver: SKScene {
    
    var starfield:SKEmitterNode!
    
    /*** Buttons On Scene ***/
    var backButton:SKSpriteNode!
    var mainMenuButton:SKSpriteNode!
    
    
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
        

        backButton = self.childNode(withName: "backButton") as! SKSpriteNode
        mainMenuButton = self.childNode(withName: "mainMenuButton") as! SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backButton" {
                
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                }
            }
            
            else if atPoint(location).name == "mainMenuButton" {
                                
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(1)))
                }
            }

        }
    }
}
