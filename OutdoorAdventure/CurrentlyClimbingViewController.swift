//
//  CurrentlyClimbingViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/31/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CurrentlyClimbingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UserClimbingModelProtocol {

    //===========GLOBAL VARIABLES===========
    
    //Button to start climbing
    @IBOutlet weak var climbingButton: UIButton!
    @IBOutlet weak var circleBackground: UIImageView!
    //Determines color
    var isClimbing : Bool = false
    
    //Toolbar for shadows
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Items from data base
    var feedItems: NSArray = NSArray()
    var items: [(Int, String, String)] = []
    
    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Sets color to gray
        circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.lightGray, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
        circleBackground.layer.shadowColor = UIColor.black.cgColor
        
        //Remove old users climbing from DB
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute, from: date)
                
        let userClimbingDeleteModel = UserClimbingRemoveRequest(endHour: hour, endMin: min)
        userClimbingDeleteModel.downloadItems()
        
        //DATABASE RECIEVE
        let userClimbingModel = UserClimbingRecieveModel()
        userClimbingModel.delegate = self
        userClimbingModel.downloadItems()
        
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
    
    //==========GET USERS CLIMBING FROM DB==========
    
    func itemsDownloaded(userClimbingItems: NSArray) {
        feedItems = userClimbingItems
        
        items.removeAll()
        
        //Change NSArray to items Tuple
        for i in 0 ..< feedItems.count {
            let userClimbing = feedItems[i] as! UserClimbingModel
            
            let profileImage = userClimbing.profileImage!
            let name = "\(userClimbing.firstName!) \(userClimbing.lastName!)"
            
            //Set up time
            var sH = userClimbing.startHour!
            var eH = userClimbing.endHour!
            var sTime = "a"
            var eTime = "a"
            if(sH > 12) {
                sH = sH - 12
                sTime = "p"
            }
            if(eH > 12) {
                eH = eH - 12
                eTime = "p"
            }
            
            var sM : String!
            var eM : String!
            
            if(userClimbing.startMin! < 10) { sM = "0\(userClimbing.startMin!)" }
            else { sM = "\(userClimbing.startMin!)" }
            
            if(userClimbing.endMin! < 10) { eM = "0\(userClimbing.endMin!)" }
            else { eM = "\(userClimbing.endMin!)" }
            
            let time = "\(sH):\(sM!)" + sTime + "-" + "\(eH):\(eM!)" + eTime
            
            items.append((profileImage, name, time))
            
            //If your email matches a user in the DB set isClimbing = true
            if(userClimbing.email?.caseInsensitiveCompare(user[0].2) == .orderedSame) {
                isClimbing = true
            }
        }
        
        collectionView.reloadData()
        
        //Sets color to green if user isClimbing
        if(isClimbing) {
            circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.green, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
            circleBackground.layer.shadowColor = UIColor.green.cgColor
        }
    }
    
    //==========SET UP COLLECTION VIEW===========
    
    //Number of items in the CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    //Sets up the cell in the CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentlyClimbingCell", for: indexPath) as! CurrentlyClimbingCollectionViewCell
        
        //Sets the image in the CollectionView
        cell.profileImage.image = UIImage(named: "\(items[indexPath.item].0).jpg")!
        cell.profileImage.image = cell.profileImage.image?.circleMasked
        //cell.profileImage = ImageTransformer.roundImageView(imageView: cell.profileImage)
        
        cell.profileName.text = items[indexPath.item].1
        cell.timeClimbing.text = items[indexPath.item].2
        
        return cell
    }
    
    //Sets the size of the size of the CollectionView cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: (collectionView.frame.width / 2), height: (collectionView.frame.width / 2))
                
        return size
    }
    
    //==========CLIMBING BUTTON CLICKED===========
    
    @IBAction func startClimbing(sender: UIButton) {
        
        //If not a guest the button can be pressed
        if(!(user[0].2.caseInsensitiveCompare("Guest") == .orderedSame) == true) {
            isClimbing = !isClimbing
        }
        
        //Sets color to green
        if(isClimbing) {
            circleBackground.image = ImageTransformer.maskRoundedImage(image: ImageTransformer.getImageWithColor(color: UIColor.green, size: circleBackground.frame.size), radius: Float(circleBackground.frame.size.width/2))
            circleBackground.layer.shadowColor = UIColor.green.cgColor
        }
        
        //Set time to climb
        if(!(user[0].2.caseInsensitiveCompare("Guest") == .orderedSame) == true) {
            performSegue(withIdentifier: "CurrentlyClimbingToDatePicker", sender: sender)
        //Sign in warning
        } else {
            let alertController = UIAlertController(title: "", message: "SIGN IN TO SET TIME", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //==========SEGUES==========
    
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

//Circle mask imageview
extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
