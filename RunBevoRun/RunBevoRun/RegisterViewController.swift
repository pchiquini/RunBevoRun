//
//  RegisterViewController.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var loginBack: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = name.text
        let pwd = password.text
        let rePwd = rePassword.text
        
        if (username == ""){
            displayAlert(userMessage: "Username is empty")
            return
        }
        
        if(pwd != rePwd){
            displayAlert(userMessage: "Passwords don't match")
            return
        }
        
    }
    
    func displayAlert(userMessage:String){
        //FIX
       // var alert = UIAlertController(nibName: "Alert", bundle: userMessage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
