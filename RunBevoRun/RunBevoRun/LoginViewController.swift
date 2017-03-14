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
    
    @IBOutlet weak var enter: UIButton!
    
    @IBOutlet weak var register: UIButton!
    
    var user: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = name.text!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
