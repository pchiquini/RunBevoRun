//
//  Congratulations.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/22/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class Congratulations: SKScene {
    
    /** Start/Loop Backgroun Music **/
    let backgroundMusic: SKAudioNode = SKAudioNode(fileNamed: "TheEyesOfTexas.mp3")
    
    /*** Buttons On Scene ***/
    var mainMenuButton:SKSpriteNode!
    var scoreButton:SKSpriteNode!
    
    /*** Starting Point ***/
    override func didMove(to view: SKView) {
        addToCore(username: UserInfo.shared.username, score: UserInfo.shared.score)
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
        scoreButton = self.childNode(withName: "scoreButton") as! SKSpriteNode
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
            
            if atPoint(location).name == "scoreButton" {
                
                /** Stop Background Music **/
                backgroundMusic.run(SKAction.stop())
                
                if let scene = Leaderboard(fileNamed: "Leaderboard") {
                    scene.scaleMode = .aspectFit
                    
                    view!.presentScene(scene, transition: SKTransition.flipHorizontal(withDuration: TimeInterval(1)))
                }
            }

        }
    }
    fileprivate func addToCore(username: String, score: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entityScore = NSEntityDescription.entity(forEntityName: "Scores", in: managedContext)
        
        let userScore = NSManagedObject(entity: entityScore!, insertInto: managedContext)
        
        userScore.setValue(username, forKey: "username")
        userScore.setValue(score, forKey: "score")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}
