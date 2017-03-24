//
//  LoginViewController.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var warningLbl: UILabel!
    
    var user: String = ""
    var loginSuccess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func login(_ sender: Any) {
        if (name.text! == ""){
            warningLbl.text = "Fill In Username"
            return
        }
        if (password.text! == ""){
            warningLbl.text = "Fill In Password"
            return
        }
        if (name.text! != password.text){
            warningLbl.text = "Password must be same as Username"
            return
        }
        loginSuccess = true
//        let username = name.text!
//        let pwd = password.text!
//        
//        let accounts = UserDefaults.standard
//        
//        let userStored = String(describing: accounts.value(forKey: "Username"))
//        let userPwdStored = String(describing: accounts.value(forKey: "Password"))
//        
//        if(userStored == username && userPwdStored == pwd){
//            accounts.set(true, forKey: "isUserLoggedIn")
//            accounts.synchronize()
//            self.dismiss(animated: true, completion: nil)
//        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "loginToGame" {
                if loginSuccess != true {
                    return false
                }
            }
        }
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //TODO pass in username
//        if (segue.identifier == "goToGame"){
//
//        }
    }

}

