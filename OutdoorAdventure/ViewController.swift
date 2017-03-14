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
        
        /*if(CANT FIND PROFILE) {
            let alertController = UIAlertController(title: "PROFILE NOT FOUND", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }*/
        
        //Get Information from data base
        if(textField_Username.text == "guest" && textField_Password.text == "guest") {
        
            performSegue(withIdentifier: "LoginToMain", sender: sender)
        }
    }
    
    @IBAction func guestSignIn(sender: UIButton) {
        performSegue(withIdentifier: "LoginToMain", sender: sender)
    }
    
    @IBAction func createProfile(sender: UIButton) {
        performSegue(withIdentifier: "LoginToCreateProfile", sender: sender)
    }
    
    
}

