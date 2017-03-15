//
//  GameViewController.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/9/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
            //if let scene = SKScene(fileNamed: "GameScene") 
            if let scene = GameScene(fileNamed: "GameScene"){
            //if let scene = MainMenu(fileNamed: "MainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

//        if let view = self.view as! SKView? {
//            
//            if let scene = SKScene(fileNamed: "GameScene") {
//                scene.scaleMode = .aspectFit
//                
//            view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1.0))
//            }
//        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
