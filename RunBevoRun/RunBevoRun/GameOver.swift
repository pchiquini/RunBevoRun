//
//  GameOver.swift
//  RunBevoRun
//
//  Created by Chiquini, Patrizio on 3/21/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class GameOver: SKScene {
    
    /*** Buttons On Scene ***/
    var backButton:SKSpriteNode!
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
        backButton = self.childNode(withName: "backButton") as! SKSpriteNode
        mainMenuButton = self.childNode(withName: "mainMenuButton") as! SKSpriteNode
        
        //TODO add score to CoreData here?
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backButton" {
                
                if let scene = GameScene(fileNamed: "GameScene1") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: TimeInterval(1)))
                }
            }
            
            else if atPoint(location).name == "mainMenuButton" {
                                
                if let scene = Leaderboard(fileNamed: "Leaderboard") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}
