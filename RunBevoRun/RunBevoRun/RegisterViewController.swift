//
//  RegisterViewController.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import CoreData

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
        
        //Register user to CoreData
        saveUser(username: username!, password: pwd!)
        
        
        //Successfully register and go back to login
        self.alertController = UIAlertController(title: "Sucess!", message: "Successfully Registered", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"Ok", style: .default) {(action) -> Void in
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC!, animated: true, completion: nil)}

        self.alertController!.addAction(okAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
       
    }
    
    func displayAlert(userMessage:String){
        
        self.alertController = UIAlertController(title: "Error", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler:nil)
        
        self.alertController!.addAction(okAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    fileprivate func saveUser(username: String, password: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Registration", in: managedContext)
        let entityScore = NSEntityDescription.entity(forEntityName: "Scores", in: managedContext)
        
        let user = NSManagedObject(entity: entity!, insertInto: managedContext)
        let userScore = NSManagedObject(entity: entityScore!, insertInto: managedContext)

        
        // Set the attribute values for users
        user.setValue(username, forKey: "username")
        user.setValue(password, forKey: "password")
        // Set the attribute values for scoreboard
        userScore.setValue(username, forKey: "username")
        UserInfo.shared.username = username
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
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
    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }

}
