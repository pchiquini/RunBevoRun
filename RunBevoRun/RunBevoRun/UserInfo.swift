//
//  Score.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 4/12/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import Foundation

class UserInfo{
    
    static let shared = UserInfo()
    var username:String = ""
    var score:Int = 0
    
    var currentScene:Int = 1
    var character:Int = 1
    var onMainMenu:Int = 1
    
    //when calling UserInfo.shared.username(score)
    //if score is static, can access directly
    
}
