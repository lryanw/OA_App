//
//  CreateProfileViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/7/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createProfile(sender: UIButton) {
        
        //If one of these is empty
        if(firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "") {
            let alertController = UIAlertController(title: "ALERT", message: "Missing Field", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        //If all the textfields are filled out
        } else {
            //If the email doesn't contain @
            if(!(emailTextField.text?.contains("@"))!) {
                let alertController = UIAlertController(title: "ALERT", message: "Incorrect Email Format", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
            let alertController = UIAlertController(title: "PROFILE CREATED", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in self.performSegue(withIdentifier: "CreateProfileToLogin", sender: self) }))
            self.present(alertController, animated: true, completion: nil)
            
            performSegue(withIdentifier: "CreateProfileToLogin", sender: sender)
        }
    }
    
    @IBAction func toLogin(sender: UIButton) {
        performSegue(withIdentifier: "CreateProfileToLogin", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
