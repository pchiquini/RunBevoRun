//
//  Leaderboard.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 4/18/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class Leaderboard: SKScene {

    /*** Buttons On Scene ***/
    var mainMenuButton:SKSpriteNode!
    
    /** Scoring **/
    var scoreLabel: SKLabelNode?
    
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
        
        /** Displaying Score From GameScene **/
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode?
        scoreLabel!.text = String(UserInfo.shared.score)
        
        /** Adding Buttons to the GameScene **/
        mainMenuButton = self.childNode(withName: "mainMenuButton") as! SKSpriteNode
        
        //TODO add score to CoreData here?
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "mainMenuButton" {
                
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}
