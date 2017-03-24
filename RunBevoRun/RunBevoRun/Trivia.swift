//
//  Trivia.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/23/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Trivia: SKScene{
    
    var button1:    SKSpriteNode!
    var button2:    SKSpriteNode!
    var nextButton: SKSpriteNode!
    var question:   SKLabelNode!
    var result:     SKLabelNode!
    
    
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
        
        button1 = self.childNode(withName: "button1") as! SKSpriteNode
        button2 = self.childNode(withName: "button2") as! SKSpriteNode
        nextButton = self.childNode(withName: "nextButton") as! SKSpriteNode
        //Appears after answer is chosen
        nextButton.isHidden = true
        
        question = self.childNode(withName: "question") as! SKLabelNode
        result = self.childNode(withName: "result") as! SKLabelNode
        //Appears after answer is chosen
        result.isHidden = true
        
        
        let button1Label = button1.childNode(withName: "button1Label") as! SKLabelNode
        let button2Label = button2.childNode(withName: "button2Label") as! SKLabelNode
        
        
        question.text = "UT's campus is greater than 40 acres"
        button1Label.text = "True"
        button2Label.text = "False"
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            //Update scene when right answer is chosen
            if atPoint(location).name == "button1" {
                
                button1.color = SKColor.green
                result.text = "Correct!"
                result.isHidden = false
                nextButton.isHidden = false
                
                //TODO include adding points here
            }
            //Update scene when wrong answer is chosen
            if atPoint(location).name == "button2" {
                
                button2.color = SKColor.red
                result.text = "Wrong"
                result.isHidden = false
                nextButton.isHidden = false
                
            }
            
            if atPoint(location).name == "nextButton"{
                
                if let scene = Congratulations(fileNamed: "Congratulations") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            
            }
        }
    }
    
    
    
    
}
