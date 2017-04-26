//
//  CreateNewsViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/18/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CreateNewsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate  {

    //=========GLOBAL VARIABLES=========
    
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
    
    //==========CREATE NEWS FOR DB==========
    
    @IBAction func createPost(sender: UIButton) {
        
        //Get Date
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let postDate = "\(month)/\(day)"
        
        //DATABASE SEND
        
        let tempText = textView.text.replacingOccurrences(of: " ", with: "_")
        
        //If there is an image picked
        if(imageView.image != nil) {
            
            //Gets the name of the last image in the server
            let newsModel = NewsAddRequestWithImage(email: user[0].2, newsDate: postDate, newsText: tempText)
            //Gets new image name then calls downloadItems()
            newsModel.getLastImagePath()
            
            //Upload image to server
            uploadImage()
            
        //If no image is picked
        } else {
            let newsModel = NewsAddRequestNoImage(email: user[0].2, newsDate: postDate, newsText: tempText)
            newsModel.downloadItems()
        }
        
        performSegue(withIdentifier: "CreateNewsToNews", sender: sender)
    }
    
    func uploadImage() {
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
        
        if(imageData == nil) { return }
    }
    
    @IBAction func cancel(sender: UIButton) {
        performSegue(withIdentifier: "CreateNewsToNews", sender: sender)
    }
    
    //=========GET IMGE FROM GALLARY=========
    
    @IBAction func pickImage(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
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
    
    //==========SEGUES=========
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateNewsToNews") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        }
    }
}

//Hide Keyboard on tap
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
