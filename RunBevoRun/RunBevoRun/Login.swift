//
//  Login.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class LoginScene: SKScene, UITextFieldDelegate{
    
    //let gameOver = SKLabelNode(fontNamed: "arial")
    // let submitScore = SKSpriteNode(imageNamed: "button")
    let wrongPwdText = SKLabelNode(fontNamed: "arial")
    var nameText: UITextField!
    var passwordText: UITextField!
    
    override func didMove(to view: SKView) {
        
        // create the UITextField instance with positions... half of the screen width minus half of the textfield width.
        // Same for the height.
        nameText = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))
        passwordText = UITextField(frame: CGRect(x: view.bounds.width / 2 - 160, y: view.bounds.height / 2 - 20, width: 320, height: 40))
        
        
        // add the UITextField to the GameScene's view
        view.addSubview(nameText)
        view.addSubview(passwordText)
        
        // add the gamescene as the UITextField delegate.
        // delegate funtion called is textFieldShouldReturn:
        nameText.delegate = self
        
        nameText.borderStyle = UITextBorderStyle.roundedRect
        nameText.textColor = SKColor.black
        nameText.placeholder = "Enter your name here"
        nameText.backgroundColor = SKColor.white
        nameText.autocorrectionType = UITextAutocorrectionType.yes
        
        nameText.clearButtonMode = UITextFieldViewMode.whileEditing
        nameText.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        self.view!.addSubview(nameText)
        
        passwordText.delegate = self
        
        passwordText.borderStyle = UITextBorderStyle.roundedRect
        passwordText.textColor = SKColor.black
        passwordText.placeholder = "Enter your name here"
        passwordText.backgroundColor = SKColor.white
        passwordText.autocorrectionType = UITextAutocorrectionType.yes
        
        passwordText.clearButtonMode = UITextFieldViewMode.whileEditing
        passwordText.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        self.view!.addSubview(passwordText)
        
        
        if( nameText.text != passwordText.text){
            wrongPwdText.fontSize = 15
            wrongPwdText.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
            wrongPwdText.text = "Wrong Password"
            addChild(wrongPwdText)
        }
    }
    
    // find method to show change scene and include
    //nameText.removefromSuperview()
    //passwordText.removefromSuperview
    
    
    // Called by tapping return on the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Populates the SKLabelNode
        //submitScoreText.text = textField.text
        
        // Hides the keyboard
        
        textField.resignFirstResponder()
        return true  
    }
}
