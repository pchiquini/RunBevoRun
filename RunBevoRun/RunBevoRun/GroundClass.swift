//
//  GroundClass.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import SpriteKit

class GroundClass: SKSpriteNode {
    
    func initGround(){
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.affectedByGravity = false;
        physicsBody?.isDynamic = false;
        physicsBody?.categoryBitMask = ColliderType.GROUND
    }
    
    /** Creating the infinity background effect **/
    func moveGrounds(camera: SKCameraNode) {
        //position.x = the view of the scence
        //size.width = the background's width
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3
        }
    }
}
