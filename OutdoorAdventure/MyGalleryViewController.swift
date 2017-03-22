//
//  MyGalleryViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/13/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class MyGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var button_Add: UIButton!
    
    //Toolbars for shadows
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    //CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Toolbar Buttons (Navigation)
    @IBOutlet weak var button_RockWall: UIBarButtonItem!
    @IBOutlet weak var button_News: UIBarButtonItem!
    @IBOutlet weak var button_Info: UIBarButtonItem!
    
    //Images in the CollectionView
    var imageItems: [UIImage] = [UIImage(named:"background_1.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!, UIImage(named:"background_2.jpg")!]
    
    var imageToPass : UIImage!
    
    //First Name, Last Name, Email,
    var user: [(String, String, String, UIImage, Bool)]!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //DATABASE RECIEVE
        
        if(!user[0].4) {
            button_Add.isHidden = true
        }
        
        //Shadows
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.5
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 10
        
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOpacity = 0.5
        bottomBar.layer.shadowOffset = CGSize.zero
        bottomBar.layer.shadowRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Number of items in the CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageItems.count
    }
    
    //Sets up the cell in the CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        
        //Sets the image in the CollectionView cell
        cell.cellImage.image = self.imageItems[indexPath.item]
        
        return cell
    }
    
    //If an image is pressed
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //Passes the image in a segue
        imageToPass = imageItems[indexPath.item]
        performSegue(withIdentifier: "GallaryToImageViewer", sender: collectionView)
    }

    
    //Sets the size of the size of the CollectionView cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: (collectionView.frame.width / 2), height: (collectionView.frame.width / 2))
        
        return size
    }
    
    //Gets image from gallery
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
            
            //DATABASE SEND
            
            collectionView.reloadData()
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //Segues
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GallaryToRockWall", sender: sender)
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GalleryToNews", sender: sender)
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        UIApplication.shared.open(NSURL(string: "https://wellness.okstate.edu/programs/outdoor-adventure") as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GalleryToCurrentlyClimbing", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GallaryToImageViewer") {
            let destinationVC = segue.destination as! ZoomedPhotoUIViewController
            destinationVC.currImage = imageToPass
            destinationVC.senderString = "Gallary"
            destinationVC.user = self.user
        } else if(segue.identifier == "GallaryToRockWall") {
            let destinationVC = segue.destination as! RockWallViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "GalleryToNews") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "GalleryToCurrentlyClimbing") {
            let destinationVC = segue.destination as! CurrentlyClimbingViewController
            destinationVC.user = self.user
        }

    }
}
