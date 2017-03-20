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

    @IBOutlet weak var rePassword: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func register(_ sender: Any) {
        let username = name.text
        let pwd = password.text
        let rePwd = rePassword.text
        
        //Check if information is complete
        if (username?.isEmpty)!{
            displayAlert(userMessage: "Username is empty")
            return
        }
        if((pwd?.isEmpty)! || (rePwd?.isEmpty)!){
            displayAlert(userMessage: "Password is empty")
            return
        }
        
        if(pwd != rePwd){
            displayAlert(userMessage: "Passwords don't match")
            return
        }
        //Add to data
        let accounts = UserDefaults.standard
        accounts.setValue(username, forKey:"Username")
        accounts.setValue(pwd, forKey:"Password")
        accounts.synchronize()
        
        //Everything complete
        //TODO have OK button go back to login?
        self.alertController = UIAlertController(title: "Alert", message: "Successfully Registered", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler:nil)
        
        self.alertController!.addAction(okAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
       
    }
    
    
    func displayAlert(userMessage:String){
        
        self.alertController = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler:nil)
        
        self.alertController!.addAction(okAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }

}
