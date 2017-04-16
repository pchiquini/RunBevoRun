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
    
    /** Buttons in Scene  **/
    var button1:    SKSpriteNode!
    var button2:    SKSpriteNode!
    var nextButton: SKSpriteNode!
    var mainMenu:   SKSpriteNode!
    var question:   SKLabelNode!
    var result:     SKLabelNode!
    
    var correctAnswer:Bool = false
    
    //var sceneApperance:Int  -> UserInfo.shared.sceneApperance
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
        print("HERE IS THE CURRENT SCENE #: ", String(UserInfo.shared.currentScene))
        UserInfo.shared.currentScene += 1
        
        button1 = self.childNode(withName: "button1") as! SKSpriteNode
        button2 = self.childNode(withName: "button2") as! SKSpriteNode
        nextButton = self.childNode(withName: "nextButton") as! SKSpriteNode
        mainMenu = self.childNode(withName: "mainMenu") as! SKSpriteNode
        
        //Appears after answer is chosen
        nextButton.isHidden = true
        mainMenu.isHidden = true
        button1.isHidden = false
        button2.isHidden = false
        
        question = self.childNode(withName: "question") as! SKLabelNode
        result = self.childNode(withName: "result") as! SKLabelNode
        //Appears after answer is chosen
        result.isHidden = true
        
        let button1Label = button1.childNode(withName: "button1Label") as! SKLabelNode
        let button2Label = button2.childNode(withName: "button2Label") as! SKLabelNode
        
        button1Label.text = "True"
        button2Label.text = "False"
        RandomQuestions()
        
    }
    
    func RandomQuestions(){
        var RandomNumber = arc4random() % 4
        RandomNumber += 1
        
        switch (RandomNumber){
        case 1:
            question.text = "UT has 2 mascots"
            correctAnswer = true
            break
            
        case 2:
            question.text = "UT was established in 1925"
            correctAnswer = false
            break
            
        case 3:
            question.text = "UT is greater than 40 acres"
            correctAnswer = true
            break
            
        case 4:
            question.text = "The Eyes of Texas is the fight song "
            correctAnswer = false
            break
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            //Update scene when right answer is chosen
            if atPoint(location).name == "button1" {
                if (correctAnswer == true){
                    //Add points
                    UserInfo.shared.score += 5
                    button1.color = SKColor.green
                    result.text = "Correct! +5 to your score"
                    result.isHidden = false
                    nextButton.isHidden = false
                    mainMenu.isHidden = true
                    button2.isHidden = true
                }else{
                    button1.color = SKColor.red
                    result.text = "Wrong"
                    result.isHidden = false
                    nextButton.isHidden = true
                    mainMenu.isHidden = false
                    button2.isHidden = true
                }
            }
            
            //Update scene when wrong answer is chosen
            if atPoint(location).name == "button2"{
                if(correctAnswer == false){
                    //Add points
                    UserInfo.shared.score += 5
                    button2.color = SKColor.green
                    result.text = "Correct! +5 to your score"
                    result.isHidden = false
                    nextButton.isHidden = false
                    mainMenu.isHidden = true
                    button1.isHidden = true
                }else{
                    button2.color = SKColor.red
                    result.text = "Wrong"
                    result.isHidden = false
                    nextButton.isHidden = true
                    mainMenu.isHidden = false
                    button1.isHidden = true
                }
            }
            
            if atPoint(location).name == "nextButton"{
               //Change to different game scene
                if (UserInfo.shared.currentScene == 1){
                    if let scene = GameScene2(fileNamed: "GameScene2") {
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                    }
                }
                
                if (UserInfo.shared.currentScene == 2){
                    if let scene = GameScene3(fileNamed: "GameScene3") {
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                    }
                }
                
                if (UserInfo.shared.currentScene == 3){
                    if let scene = GameScene4(fileNamed: "GameScene4") {
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                    }
                }
                
                if (UserInfo.shared.currentScene == 4){
                    if let scene = Congratulations(fileNamed: "Congratulations") {
                        scene.scaleMode = .aspectFit
                        
                        view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                    }
                }
                
            }
            
            if atPoint(location).name == "mainMenu"{
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }
        }
    }
}
