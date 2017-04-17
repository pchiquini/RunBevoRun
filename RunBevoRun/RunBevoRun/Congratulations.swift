//
//  Congratulations.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/22/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit

class Congratulations: SKScene {
    
    /** Start/Loop Backgroun Music **/
    let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "TheEyesOfTexas.mp3")
    
    /*** Buttons On Scene ***/
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
        
        /** Start/Loop Backgroun Music **/
        self.addChild(backgroundMusic)
        
         /** Buttons in Scene  **/
        mainMenuButton = self.childNode(withName: "mainMenuButton") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "mainMenuButton" {
                
                /** Stop Background Music **/
                backgroundMusic.run(SKAction.stop())
                
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}
