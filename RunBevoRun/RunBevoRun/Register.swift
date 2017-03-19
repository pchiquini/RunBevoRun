//
//  Register.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/19/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Register: SKScene, UITextFieldDelegate{
    
    let wrongPwdText = SKLabelNode(fontNamed: "arial")
    var nameText: UITextField!
    var passwordText: UITextField!
    var rePasswordText: UITextField!

    var register:SKSpriteNode!
    var back:SKSpriteNode!
    
    
    
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
        
        let rePwdBox = self.childNode(withName: "rePassword")
        let rePwdBoxPosX = rePwdBox?.position.x
        let rePwdBoxPosY = rePwdBox?.position.y
        
        register = self.childNode(withName: "registerButton") as! SKSpriteNode!
        back = self.childNode(withName: "backButton") as! SKSpriteNode!
        nameText = UITextField(frame: CGRect(x: nameBoxPosX!, y: nameBoxPosY!, width: 209, height: 40))
        passwordText = UITextField(frame: CGRect(x: pwdBoxPosX!, y: pwdBoxPosY!, width: 209, height: 40))
        rePasswordText = UITextField(frame: CGRect(x: rePwdBoxPosX!, y: rePwdBoxPosY!, width: 209, height: 40))
        
        
        // add the UITextField to the GameScene's view
        view.addSubview(nameText)
        view.addSubview(passwordText)
        view.addSubview(rePasswordText)
        
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
        
        rePasswordText.delegate = self
        
        rePasswordText.borderStyle = UITextBorderStyle.roundedRect
        rePasswordText.textColor = SKColor.black
        rePasswordText.placeholder = "Password"
        rePasswordText.backgroundColor = SKColor.white
        
        rePasswordText.clearButtonMode = UITextFieldViewMode.whileEditing
        self.view!.addSubview(rePasswordText)
        
        
        if( passwordText.text != rePasswordText.text){
            wrongPwdText.fontSize = 15
            //TODO - fix postio
            wrongPwdText.position = CGPoint(x: rePwdBoxPosX!, y: rePwdBoxPosY! + 5)
            wrongPwdText.text = "Passwords don't match"
            addChild(wrongPwdText)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            
            let node = self.nodes(at: location)
            
            if node[0].name == "registerButton" {
                let menuScene = MainMenu(size: self.size)
                nameText.removeFromSuperview()
                passwordText.removeFromSuperview()
                rePasswordText.removeFromSuperview()
                //TODO - may have to pass username here
                self.view!.presentScene(menuScene)
            }else if node[0].name == "backButton" {
                let loginScene = Login(size:self.size)
                nameText.removeFromSuperview()
                passwordText.removeFromSuperview()
                rePasswordText.removeFromSuperview()
                self.view!.presentScene(loginScene)
            }
        }
        
    }
    
    // Called by tapping return on the keyboard.
    // TODO inline?
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Populates the SKLabelNode
        //submitScoreText.text = textField.text
        
        // Hides the keyboard
        
        textField.resignFirstResponder()
        return true
    }
}
