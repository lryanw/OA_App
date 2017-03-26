//
//  ViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/8/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField_Username: UITextField!
    @IBOutlet weak var textField_Password: UITextField!
    @IBOutlet weak var button_SignIn: UIButton!
    
    //First Name, Last Name, Email, Profile Image, IsEmployee
    var user: [(String, String, String, Int, Bool)] = [("Guest","Guest","Guest", 1, true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField_Username.delegate = self
        textField_Password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //On Sign In button click
    @IBAction func signIn(sender: UIButton) {
        
        if(textField_Username.text == "" || textField_Password.text == "") {
            let alertController = UIAlertController(title: "ENTER PROFILE INFO", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            user[0].2 = textField_Username.text!
        }
        
        //DATABASE RECIEVE
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Segues
    @IBAction func guestSignIn(sender: UIButton) {
        user[0].2 = "Guest"
        
        performSegue(withIdentifier: "LoginToMain", sender: sender)
    }
    
    @IBAction func createProfile(sender: UIButton) {
        performSegue(withIdentifier: "LoginToCreateProfile", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "LoginToMain") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        }
    }
}

