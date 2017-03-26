//
//  CreateNewsViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/18/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CreateNewsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate  {

    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
    
    @IBOutlet weak var textView: UITextView!
    
    //To get image from gallery
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Adds new post to database
    @IBAction func createPost(sender: UIButton) {
        
        //DATABASE SEND
        
        performSegue(withIdentifier: "CreateNewsToNews", sender: sender)
    }
    
    @IBAction func cancel(sender: UIButton) {
        performSegue(withIdentifier: "CreateNewsToNews", sender: sender)
    }
    
    //Get Image from gallery
    @IBAction func pickImage(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateNewsToNews") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        }
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
