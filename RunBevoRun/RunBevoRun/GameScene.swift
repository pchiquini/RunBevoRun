//
//  GameScene.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/9/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //add variable from GameScene
    var aladdin:SKSpriteNode?
    var test:SKSpriteNode?
    var ground1:SKSpriteNode?
    var platform1:SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        //intiantiate the variables from the GameScence
        aladdin = self.childNode(withName: "aladdin") as? SKSpriteNode
        test = self.childNode(withName: "test") as? SKSpriteNode
        ground1 = self.childNode(withName: "ground1") as? SKSpriteNode
        platform1 = self.childNode(withName: "platform1") as? SKSpriteNode
    
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        jump()
    
    }
    
    func jump() {
        
        aladdin?.texture = SKTexture(imageNamed: "aladdin")
        aladdin?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Apply forces
        platform1?.physicsBody?.applyForce(CGVector(dx: -30, dy: 0))
        //platform1?.physicsBody?.velocity
        
        
        //Apply animiations
        
        
    }
}
