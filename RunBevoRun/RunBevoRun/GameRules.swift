//
//  GameRules.swift
//  RunBevoRun
//
//  Created by Chiquini, Patrizio on 3/21/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit

class GameRules: SKScene {
    
    var starfield:SKEmitterNode!
    
    /*** Buttons On Scene ***/
    var backButton:SKSpriteNode!

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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backButton" {
                
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}
