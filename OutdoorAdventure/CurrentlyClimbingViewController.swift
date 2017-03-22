//
//  CurrentlyClimbingViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/31/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CurrentlyClimbingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //Button to start climbing
    @IBOutlet weak var climbingButton: UIButton!
    @IBOutlet weak var circleBackground: UIImageView!
    var isClimbing = false
    
    //Toolbar for shadows
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Items from data base
    var items: [(UIImage, String, String)] = [(UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min"), (UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min"), (UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min"), (UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min"), (UIImage(named: "ic_launcher.png")!, "Ryan Lee", "30 min")]
    
    //First Name, Last Name, Email,
    var user: [(String, String, String, UIImage, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //DATABASE RECIEVE
        
        //Gets the color of the circle depending on whether the user has set a time to climb or not
        if(isClimbing) {
            circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.green, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
            circleBackground.layer.shadowColor = UIColor.green.cgColor
        } else {
            circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.lightGray, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
            circleBackground.layer.shadowColor = UIColor.black.cgColor
        }
        
        //Shadows
        circleBackground.layer.shadowColor = UIColor.black.cgColor
        circleBackground.layer.shadowOpacity = 0.5
        circleBackground.layer.shadowOffset = CGSize.zero
        circleBackground.layer.shadowRadius = 10
        
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
        return self.items.count
    }
    
    //Sets up the cell in the CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentlyClimbingCell", for: indexPath) as! CurrentlyClimbingCollectionViewCell
        
        //Sets the image in the CollectionView cell
        cell.profileImage.image = ImageTransformer.maskRoundedImage(image: items[indexPath.item].0, radius: Float(cell.profileImage.frame.width/2))
        cell.profileName.text = items[indexPath.item].1
        cell.timeClimbing.text = items[indexPath.item].2
        
        return cell
    }
    
    //Sets the size of the size of the CollectionView cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: (collectionView.frame.width / 2), height: (collectionView.frame.width / 2))
                
        return size
    }
    
    //Select a time to climb at
    @IBAction func startClimbing(sender: UIButton) {
        isClimbing = !isClimbing
        if(isClimbing) {
            circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.green, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
            circleBackground.layer.shadowColor = UIColor.green.cgColor
        } else {
            circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.lightGray, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
            circleBackground.layer.shadowColor = UIColor.black.cgColor
        }
        
        performSegue(withIdentifier: "CurrentlyClimbingToDatePicker", sender: sender)
    }
    
    //Segues
    @IBAction func toGallery(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToGallery", sender: sender)
    }
    
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToRockWall", sender: sender)
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CurrentlyClimbingToNews", sender: sender)
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        UIApplication.shared.open(NSURL(string: "https://wellness.okstate.edu/programs/outdoor-adventure") as! URL, options: [:], completionHandler: nil)
        //performSegue(withIdentifier: "CurrentlyClimbingToInfo", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CurrentlyClimbingToGallery") {
            let destinationVC = segue.destination as! MyGalleryViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "CurrentlyClimbingToNews") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "CurrentlyClimbingToRockWall") {
            let destinationVC = segue.destination as! RockWallViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "CurrentlyClimbingToDatePicker") {
            let destinationVC = segue.destination as! TimePickerViewController
            destinationVC.user = self.user
        }
    }
}
