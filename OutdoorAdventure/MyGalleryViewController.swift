//
//  MyGalleryViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/13/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class MyGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //if(!user.isEmployee()) {
        button_Add.isHidden = true
        //}
        
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
        
        //Image Gallary
        
        return cell
    }
    
    //If an image is pressed
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //NOT WORKING

        //Passes the image in a segue
        imageToPass = imageItems[indexPath.item]
        performSegue(withIdentifier: "GallaryToImageViewer", sender: collectionView)
    }

    
    //Sets the size of the size of the CollectionView cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: (collectionView.frame.width / 2), height: (collectionView.frame.width / 2))
        
        return size
    }
    
    @IBAction func addNewImage(sender: UIButton) {
        
    }
    
    //Segues
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GallaryToRockWall", sender: sender)
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GalleryToNews", sender: sender)
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GallaryToInfo", sender: sender)
    }
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GalleryToCurrentlyClimbing", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GallaryToImageViewer") {
            let destinationVC = segue.destination as! ZoomedPhotoUIViewController
            destinationVC.currImage = imageToPass
            destinationVC.senderString = "Gallary"
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
