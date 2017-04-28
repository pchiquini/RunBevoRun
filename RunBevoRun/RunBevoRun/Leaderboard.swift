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
    /*** Score Array ***/
    var scores = [NSManagedObject]()
    
    /*** Buttons On Scene ***/
    var mainMenuButton:SKSpriteNode!
    
    /** Scoring **/
    var player1:    SKLabelNode?
    var player2:    SKLabelNode?
    var player3:    SKLabelNode?
    var player4:    SKLabelNode?
    var score1:     SKLabelNode?
    var score2:     SKLabelNode?
    var score3:     SKLabelNode?
    var score4:     SKLabelNode?
    
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
        score1 = self.childNode(withName: "score1") as! SKLabelNode?
        score1!.text = String(UserInfo.shared.score)
        
        /** Adding Buttons to the GameScene **/
        mainMenuButton = self.childNode(withName: "mainMenuButton") as! SKSpriteNode
        
        //TODO add score to CoreData here?
        
        loadData()
    }
    
    fileprivate func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Scores")
        
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
