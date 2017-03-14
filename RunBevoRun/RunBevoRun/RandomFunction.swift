//
//  RandomFunction.swift
//  RunBevoRun
//
//  Created by Patrizio Chiquini on 3/13/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat{
        return CGFloat.random() * (max - min) + min
    }
}
