//
//  LevelCompleted.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/22/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit

class LevelCompleted: SKScene {
    
    /** Buttons On Scene **/
    var backButton:SKSpriteNode!
    var nextButton:SKSpriteNode!
    
    /** Scoring **/
    var scoreLabel: SKLabelNode?
    
    //You need to create a pointer to it manually. 
    //This can be done by creating a property for the SKScene: maybe?
    var viewcontroller: UIViewController!
    let newViewController = Trivia()
    
    /** Starting Point **/
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
        nextButton = self.childNode(withName: "nextButton") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backButton" {
                
                if let scene = GameScene(fileNamed: "GameScene1") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }

            ////////HOW TO GO TO THE STORY BOARD////
            //EDITS NEED TO BE DONE BETWEEN HERE AND
            if atPoint(location).name == "nextButton" {
                
                if let scene = Trivia(fileNamed: "Trivia") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }
            //AND HERE CAN BE EDITED AND/OR REMOVED////
            ///////////////////////////////////////
        }
    }
}
