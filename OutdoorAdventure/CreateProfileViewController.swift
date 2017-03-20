//
//  CreateProfileViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/7/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    var images : [UIImage] = [UIImage(named: "1.jpg")!, UIImage(named: "2.jpg")!, UIImage(named: "3.jpg")!, UIImage(named: "4.jpg")!, UIImage(named: "5.jpg")!, UIImage(named: "6.jpg")!, UIImage(named: "7.jpg")!, UIImage(named: "8.jpg")!]
    
    var currImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        profileImage = ImageTransformer.roundImageView(imageView: profileImage)
        profileImage.image = images[currImage]
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "CreateProfileToProfileImagePicker", sender: self)
    }
    
    //Changes the image on tap
    @IBAction func changeProfileImage(sender: UIButton) {
        if(currImage == images.count - 1) { currImage = 0 }
        else { currImage += 1 }
        
        profileImage.image = images[currImage]
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
            
            //DATABASE SEND
            
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
}
