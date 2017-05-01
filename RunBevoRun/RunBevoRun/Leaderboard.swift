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
import GameKit

class Leaderboard: SKScene {
    /*** Score Array ***/
    var scores = [NSManagedObject]()
    
    /*** Buttons On Scene ***/
    var mainMenuButton:SKSpriteNode!
    
    /** Scoring **/
    var player1:    SKLabelNode!
    var player2:    SKLabelNode!
    var player3:    SKLabelNode!
    var player4:    SKLabelNode!
    var score1:     SKLabelNode!
    var score2:     SKLabelNode!
    var score3:     SKLabelNode!
    var score4:     SKLabelNode!
    
    /*** Starting Point ***/
    override func didMove(to view: SKView) {
        
        loadCoreData()
        
        
        createScene()
        
        
    }
    
    /********************************************************************/
    /*                                                                  */
    /*                        CREATING THE SCENCE                       */
    /*                                                                  */
    /********************************************************************/
    
    func createScene() {
        
        /** Adding Buttons to the GameScene **/
        mainMenuButton = self.childNode(withName: "mainMenuButton") as! SKSpriteNode
        
        player1 = self.childNode(withName: "player1") as? SKLabelNode
        player2 = self.childNode(withName: "player2") as? SKLabelNode
        player3 = self.childNode(withName: "player3") as? SKLabelNode
        player4 = self.childNode(withName: "player4") as? SKLabelNode
        score1 = self.childNode(withName: "score1") as? SKLabelNode
        score2 = self.childNode(withName: "score2") as? SKLabelNode
        score3 = self.childNode(withName: "score3") as? SKLabelNode
        score4 = self.childNode(withName: "score4") as? SKLabelNode
        
        self.run(SKAction.wait(forDuration: 1)){
            self.findHighScore()
        }
        
    }
    
    
    fileprivate func findHighScore(){
        
        //Now that scores is sorted by score,
        //Get first 4 scores and and change the text
        for index in 0...3{
            
            let user: String = (scores[index].value(forKey: "username") as? String)!
            let userScore: Int = (scores[index].value(forKey: "score") as? Int)!
            
            if (index == 0 ){
                if(user == ""){
                    player1?.text = "Unknown"
                }else{
                    player1?.text = user
                }
                score1?.text = String(userScore)
            }
            else if (index == 1 && scores.count > 1){
                if(user == ""){
                    player2?.text = "Unknown"
                }else{
                    player2?.text = user
                }
                score2?.text = String(userScore)
            }
            else if (index == 2 && scores.count > 2){
                if(user == ""){
                    player3?.text = "Unknown"
                }else{
                    player3?.text = user
                }
                score3?.text = String(userScore)
            }
            else if (index == 3 && scores.count > 3){
                if(user == ""){
                    player4?.text = "Unknown"
                }else{
                    player4?.text = user
                }
                score4?.text = String(userScore)
            }
        }
    }
    

    
    
    fileprivate func loadCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Scores")
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            scores = results
        } else {
            print("Could not fetch")
        }
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
