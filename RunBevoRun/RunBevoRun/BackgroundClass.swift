//
//  BackgroundClass.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

class BackgroundClass: SKSpriteNode {
    
    /** Creating the infinity background effect **/
    func moveBG(camera: SKCameraNode) {
        //position.x = the view of the scence
        //size.width = the background's width
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3
        }
    }

    func initBackWall(){
        
        /* Helps with Collisions */
        name = "BackWall"
        
        /* Coding/Setting Some Properties of Player */
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 20, height: self.size.height - 10))
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        
        /*   Collision and Contact Masks   */
        physicsBody?.categoryBitMask = ColliderType.GROUND
        physicsBody?.contactTestBitMask = ColliderType.PLAYER
    }
    
    /* Handles BackWall Automatic Movement */
    func backWallMove(){
        self.position.x += 10
    }
}
