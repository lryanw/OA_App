//
//  ViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/8/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UserModelProtocol {
    
    @IBOutlet weak var textField_Username: UITextField!
    @IBOutlet weak var textField_Password: UITextField!
    @IBOutlet weak var button_SignIn: UIButton!
    
    //First Name, Last Name, Email, Profile Image, IsEmployee
    var user: [(String, String, String, Int, Bool)] = [("Guest","Guest","Guest", 1, true)]
    
    var foundUser = false
    
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
    
    func itemsDownloaded(userItems: NSArray) {
        let feedItems : NSArray = userItems
        
        //Change NSArray to items Tuple
        for i in 0 ..< feedItems.count {
            let userModel = feedItems[i] as! UserModel
            if(userModel.email == textField_Username.text) {
                user[0].0 = userModel.firstName!
                user[0].1 = userModel.lastName!
                user[0].2 = userModel.email!
                user[0].3 = userModel.profileImage!
                user[0].4 = (userModel.isEmployee != nil)
                foundUser = true
                break
            }
        }
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
        let userModel = UserRecieveModel(pEmail: textField_Username.text!, pPassword: textField_Password.text!)
        userModel.delegate = self
        userModel.downloadItems()
        
        //If the user is no found
        if(!foundUser) {
            let alertController = UIAlertController(title: "PROFILE NOT FOUND", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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

