//
//  CreateRouteViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/14/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class CreateRouteViewController: UIViewController, UITextFieldDelegate, RouteAddProtocol {

    @IBOutlet weak var routeName: UITextField!
    @IBOutlet weak var setterName: UITextField!
    
    @IBOutlet weak var button_Rating: UIButton!
    @IBOutlet weak var button_Overlay: UIButton!
    @IBOutlet weak var button_Color: UIButton!
    @IBOutlet weak var button_Rope: UIButton!
    
    @IBOutlet weak var colorImage: UIImageView!
    @IBOutlet weak var overlayImage: UIImageView!
    
    @IBOutlet weak var background_WhiteCircle_1: UIImageView!
    @IBOutlet weak var background_WhiteColor_2: UIImageView!
    @IBOutlet weak var background_WhiteColor_3: UIImageView!
    
    var currColor = 0
    var currOverlay = 0
    var currRoute = 0
    var currRope = 0
    
    //All Ropes
    var ropes : [String] = ["1","2", "3", "4", "5", "6", "7", "8", "9", "10", "E", "W"]
    
    //All ratings
    var routeArray : [String] = ["B-", "B", "B+", "I-", "I", "I+", "A-", "A", "A+", "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12"]
    
    //All overlays
    var overlayArray : [UIImage] = [ImageTransformer.getImageWithColor(color: UIColor.white, size: CGSize(width: 150, height: 150)), UIImage(named: "Yin_yang.png")!, UIImage(named: "Celtic_Knot_Edit_2.png")!, UIImage(named: "MoonAndStars.png")!, UIImage(named: "Camo_Overlay_Circle.png")!]
    var overlayNameArray : [String] = ["nil", "YinYang", "Celtic", "MoonAndStars", "Camo"]
    
    //All colors
    //Red, Pink, Orange, Yellow, Green, Blue, Purple, Gray, Brown, Black, White
    var colorArray : [UIColor] = [UIColor.red, UIColor.init(red: 255/255, green: 105/255, blue: 180/255, alpha: 1), UIColor.orange, UIColor.yellow, UIColor.green, UIColor.init(red: 173/255, green: 216/255, blue: 230/255, alpha: 1), UIColor.blue, UIColor.purple, UIColor.lightGray, UIColor.brown, UIColor.black, UIColor.white]
    var colorNameArray : [String] = ["Red", "Pink", "Orange", "Yellow", "Green", "Light Blue", "Blue", "Purple", "Gray", "Brown", "Black", "White"]
    
    //FirstName, LastName, Email, ProfileImage, IsEmployee
    var user : [(String, String, String, Int, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeName.delegate = self
        setterName.delegate = self
        
        //Background circle
        background_WhiteCircle_1 = ImageTransformer.roundImageView(imageView: background_WhiteCircle_1)
        background_WhiteColor_2 = ImageTransformer.roundImageView(imageView: background_WhiteColor_2)
        background_WhiteColor_3 = ImageTransformer.roundImageView(imageView: background_WhiteColor_3)
        
        //Overlay setup
        overlayImage.image = overlayArray[currOverlay]
        overlayImage = ImageTransformer.roundImageView(imageView: overlayImage)
        
        //Color setup
        colorImage.image = ImageTransformer.getImageWithColor(color: colorArray[currColor], size: colorImage.frame.size)
        colorImage = ImageTransformer.roundImageView(imageView: colorImage)
    }
    
    func itemsDownloaded(routeItems: NSArray) {
        //
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func cancelCreateRoute(sender: UIButton) {
        performSegue(withIdentifier: "CreateRouteToRockWall", sender: self)
    }
    
    //Adds new route to database
    @IBAction func createRoute(sender: UIButton) {
        
        //Prevents Error with special characters
        if((routeName.text!.contains("'") || setterName.text!.contains("'"))) {
            
            let alertController = UIAlertController(title: "DATABASE DOES NOT SUPPORT SPECIAL CHARACTERS", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        //DATABASE SEND
        let routeModel = RouteAddRequest(color: colorNameArray[currColor], overlay: overlayNameArray[currOverlay], name: routeName.text!, rating: routeArray[currRoute], setter: setterName.text!, rope: ropes[currRope])
        routeModel.delegate = self
        routeModel.downloadItems()
        
        performSegue(withIdentifier: "CreateRouteToRockWall", sender: self)
    }
    
    //For setting up rope
    @IBAction func changeRope(sender: UIButton) {
        if(currRope == ropes.count - 1) { currRope = 0 }
        else { currRope += 1 }
        
        button_Rope.setTitle(ropes[currRope], for: UIControlState.normal)
    }
    
    @IBAction func changeColor(sender: UIButton) {
        if(currColor == colorArray.count - 1) { currColor = 0 }
        else { currColor += 1 }
        
        colorImage.image = ImageTransformer.getImageWithColor(color: colorArray[currColor], size: colorImage.frame.size)
    }
    
    @IBAction func changeOverlay(sender: UIButton) {
        if(currOverlay == overlayArray.count - 1) { currOverlay = 0 }
        else { currOverlay += 1 }
        
        overlayImage.image = overlayArray[currOverlay]
    }
    
    @IBAction func changeRoute(sender: UIButton) {
        if(currRoute == routeArray.count - 1) { currRoute = 0 }
        else { currRoute += 1 }
        
        button_Rating.setTitle(routeArray[currRoute], for: UIControlState.normal)
    }
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateRouteToRockWall") {
            let destinationVC = segue.destination as! RockWallViewController
            destinationVC.user = self.user
        }
    }
}
