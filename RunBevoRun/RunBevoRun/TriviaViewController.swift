//
//  TriviaViewController.swift
//  RunBevoRun
//
//  Created by Rachel Andrews on 3/20/17.
//  Copyright © 2017 Chiquini. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var button1: UIButton!

    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var endLabel: UILabel!
    
    var correctAnswer:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func RandomQuestions(){
        var RandomNumber = arc4random() % 4
        RandomNumber += 1
        
        switch (RandomNumber){
        case 1:
            question.text = "What is the name of the current mascot?"
            button1.setTitle("Bevo", for: UIControlState.normal)
            button2.setTitle("Cleo", for: UIControlState.normal)
            button3.setTitle("Maurice", for: UIControlState.normal)
            button4.setTitle("Revielle", for: UIControlState.normal)
            correctAnswer = "1"
            break
            
        case 2:
            question.text = "What is UT's colors?"
            button1.setTitle("Burnt Orange and White", for: UIControlState.normal)
            button2.setTitle("Crimson and Cream", for: UIControlState.normal)
            button3.setTitle("Navy and Yellow", for: UIControlState.normal)
            button4.setTitle("Orange and Cream", for: UIControlState.normal)
            break
            
        case 3:
            question.text = "How many acres is UT"
            button1.setTitle("890", for: UIControlState.normal)
            button2.setTitle("400", for: UIControlState.normal)
            button3.setTitle("320", for: UIControlState.normal)
            button4.setTitle("40", for: UIControlState.normal)
            break
            
        case 4:
            question.text = "What is the likelihood you will come"
            button1.setTitle("100", for: UIControlState.normal)
            button2.setTitle("300", for: UIControlState.normal)
            button3.setTitle("50", for: UIControlState.normal)
            button4.setTitle("0", for: UIControlState.normal)
            break
        default:
            break
        }
        
    }
    
    @IBAction func tapButton1(_ sender: Any) {
        if (correctAnswer == "1"){
            endLabel.text = "Correct"
        }else{
            endLabel.text = "Wrong"
        }
    }
    @IBAction func tapButton2(_ sender: Any) {
        if (correctAnswer == "2"){
            endLabel.text = "Correct"
        }else{
            endLabel.text = "Wrong"
        }
    }
    @IBAction func tapButton3(_ sender: Any) {
        if (correctAnswer == "3"){
            endLabel.text = "Correct"
        }else{
            endLabel.text = "Wrong"
        }
    }
    @IBAction func tapButton4(_ sender: Any) {
        if (correctAnswer == "4"){
            endLabel.text = "Correct"
        }else{
            endLabel.text = "Wrong"
        }
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
