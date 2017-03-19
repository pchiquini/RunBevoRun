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

class Login: SKScene, UITextFieldDelegate{
    
    let wrongPwdText = SKLabelNode(fontNamed: "arial")
    var nameText: UITextField!
    var passwordText: UITextField!
    
    var login:SKSpriteNode!
    var register:SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        
        // create the UITextField instance with positions... half of the screen width minus half of the textfield width.
        // Same for the height.
        
        //need to change width and height
        let nameBox = self.childNode(withName: "username")
        let nameBoxPosX = nameBox?.position.x
        let nameBoxPosY = nameBox?.position.y
        
        let pwdBox = self.childNode(withName: "password")
        let pwdBoxPosX = pwdBox?.position.x
        let pwdBoxPosY = pwdBox?.position.y
        
        login = self.childNode(withName: "loginButton") as! SKSpriteNode!
        register = self.childNode(withName: "registerButton") as! SKSpriteNode!
        nameText = UITextField(frame: CGRect(x: nameBoxPosX!, y: nameBoxPosY!, width: 209, height: 40))
        passwordText = UITextField(frame: CGRect(x: pwdBoxPosX!, y: pwdBoxPosY!, width: 209, height: 40))
        
        
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
        
        nameText.clearButtonMode = UITextFieldViewMode.whileEditing
        self.view!.addSubview(nameText)
        
        passwordText.delegate = self
        
        passwordText.borderStyle = UITextBorderStyle.roundedRect
        passwordText.textColor = SKColor.black
        passwordText.placeholder = "Password"
        passwordText.backgroundColor = SKColor.white
        
        passwordText.clearButtonMode = UITextFieldViewMode.whileEditing
        self.view!.addSubview(passwordText)
        
        
        if( nameText.text != passwordText.text){
            wrongPwdText.fontSize = 15
            wrongPwdText.position = CGPoint(x: nameBoxPosX!, y: nameBoxPosY! - 15)
            wrongPwdText.text = "Wrong Password"
            addChild(wrongPwdText)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            
            let node = self.nodes(at: location)
            
            if node[0].name == "loginButton" {
                let menuScene = MainMenu(size: self.size)
                nameText.removeFromSuperview()
                passwordText.removeFromSuperview()
                self.view!.presentScene(menuScene)
            }else if node[0].name == "registerButton" {
                let registerScene = Register(size:self.size)
                nameText.removeFromSuperview()
                passwordText.removeFromSuperview()
                self.view!.presentScene(registerScene)
            }
        }
        
    }
    
    // Called by tapping return on the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Populates the SKLabelNode
        //submitScoreText.text = textField.text
        
        // Hides the keyboard
        
        textField.resignFirstResponder()
        return true  
    }
}
