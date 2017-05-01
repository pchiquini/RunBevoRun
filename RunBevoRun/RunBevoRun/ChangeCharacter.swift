//
//  ChangeCharacter.swift
//  RunBevoRun
//
//  Created by Chiquini, Patrizio on 3/21/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit

class ChangeCharacter: SKScene {
    
    var starfield:SKEmitterNode!
    
    /** Buttons On Scene **/
    var backButton:SKSpriteNode!
    var bevoCharacter:SKSpriteNode!
    var hookEmCharacter:SKSpriteNode!
    var highlight1: SKShapeNode!
    var highlight2: SKShapeNode!
    var box1: SKShapeNode!
    var box2: SKShapeNode!
    
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
        
        backButton = self.childNode(withName: "backButton") as! SKSpriteNode
        highlight1 = self.childNode(withName: "highlight1") as! SKShapeNode
        highlight2 = self.childNode(withName: "highlight2") as! SKShapeNode
        box1 = self.childNode(withName: "box1") as! SKShapeNode
        box2 = self.childNode(withName: "box2") as! SKShapeNode
        
        /** Identifying which character has been chosen **/
        highlight1.isHidden = true
        highlight2.isHidden = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backButton" {
                
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }
            
            if (atPoint(location).name == "character1" ||  atPoint(location).name == "box1") {
                UserInfo.shared.character = 1
                highlight1.isHidden = false
                highlight2.isHidden = true
            }
            
            if (atPoint(location).name == "character2" ||  atPoint(location).name == "box2") {
                UserInfo.shared.character = 2
                highlight2.isHidden = false
                highlight1.isHidden = true

            }

        }
    }
}
