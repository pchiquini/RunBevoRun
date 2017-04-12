//
//  LoginViewController.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/14/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var warningLbl: UILabel!
    
    //Change to global variable
    public var user: String = ""
    var loginSuccess: Bool = false
    
    var users = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
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
        if (!findUser()){
            return
        }
        loginSuccess = true
        
        user = name.text!

    }
    //Checks for existing user and matching password
    func findUser() -> Bool{
        //Search through all users to find username
        for user in users{
            let username: String = (user.value(forKey: "username") as? String)!
            let pwd: String = (user.value(forKey: "password") as? String)!
            if (username == name.text!){
                if (pwd == password.text!){
                    return true
                }else{
                    warningLbl.text = "Password incorrect."
                    return false
                }
            }
        }
        warningLbl.text = "Username not found."
        return false
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
    
    fileprivate func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Registration")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            users = results
        } else {
            print("Could not fetch")
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//   
//    }

}

