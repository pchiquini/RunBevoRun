//
//  LevelCompleted.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/22/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

class LevelCompleted: SKScene {
    
    /*** Buttons On Scene ***/
    var backButton:SKSpriteNode!
    var nextButton:SKSpriteNode!
    
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
        nextButton = self.childNode(withName: "nextButton") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "backButton" {
                
                if let scene = GameScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }
            
            if atPoint(location).name == "nextButton" {
                    
                if let scene = Congratulations(fileNamed: "Congratulations") {
                    scene.scaleMode = .aspectFit
                        
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }
                
        }
    }
}
