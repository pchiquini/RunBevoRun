//
//  Scoreboard.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 4/16/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import Foundation
import CoreData
import SpriteKit

class Scoreboard: SKScene{
    
    /** Buttons in Scene  **/
    var user1:   SKLabelNode!
    var user2:   SKLabelNode!
    var user3:   SKLabelNode!
    var user4:   SKLabelNode!
    var user5:   SKLabelNode!
    var score1:  SKLabelNode!
    var score2:  SKLabelNode!
    var score3:  SKLabelNode!
    var score4:  SKLabelNode!
    var score5:  SKLabelNode!
    
    var nextButton:    SKSpriteNode!
    

    
    var score:Int = UserInfo.shared.score
    //var sceneApperance = UserInfo.shared.currentScene
    
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
        
        nextButton = self.childNode(withName: "nextButton") as! SKSpriteNode
        
        //Appears after answer is chosen
        pullFromCore()
        
    }
    /********************************************************************/
    /*                                                                  */
    /*                       UPDATE SCOREBOARD                          */
    /*                                                                  */
    /********************************************************************/
    func pullFromCore(){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "nextButton"{
                //Change to different game scene
                if (UserInfo.shared.currentScene == 1){
                    if let scene = GameScene2(fileNamed: "GameScene2") {
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                    }
                }
            }
        }
    }
}


