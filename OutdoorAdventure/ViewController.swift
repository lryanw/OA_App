//
//  ViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/8/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField_Username: UITextField!
    @IBOutlet weak var textField_Password: UITextField!
    @IBOutlet weak var button_SignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //On Sign In button click
    @IBAction func signIn(sender: UIButton) {
        
        //Get Information from data base
        if(textField_Username.text == "guest" && textField_Password.text == "guest") {
        
            performSegue(withIdentifier: "LoginToMain", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

