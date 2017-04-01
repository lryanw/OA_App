//
//  RockWallViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/13/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit
import QuartzCore

class RockWallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RouteModelProtocol {
    
    @IBOutlet weak var button_Add: UIButton!
    
    //Toolbars for shadows
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var topBar: UIToolbar!
    
    //Routes Graphic
    @IBOutlet weak var routesCircleGraphic: UIImageView!
    var currentRoute = 0
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var currentRouteLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //TableView
    @IBOutlet weak var routeTableView: UITableView!
    
    var origionalSize : CGSize!
    var origionalPoint : CGPoint!
    var setOrigionalSize = false
    
    //Route Name, Setter, Difficulty, Color, Symbol, Rope #
    var feedItems : NSArray!
    var itemsAll: [(String, String, String, UIColor, String, Int)] = [("Up Up And Away", "Ryan Lee", "I+", UIColor.red, "nil", 1), ("Up Up And Away", "Ryan Lee", "B", UIColor.yellow, "Celtic", 5), ("Up Up And Away", "Ryan Lee", "A-", UIColor.blue, "Camo", 7), ("Up Up And Away", "Ryan Lee", "V12", UIColor.blue, "Camo", 11)]
    
    var itemsRope: [(String, String, String, UIColor, String, Int)] = []
    
    var ropes = ["1","2","3","4","5","6","7","8","9","10","E","W"]
    
    //Red, Pink, Orange, Yellow, Green, Light Blue, Blue, Purple, Gray, Brown, Black, White
    var colorArray : [UIColor] = [UIColor.red, UIColor.init(red: 255/255, green: 105/255, blue: 180/255, alpha: 1), UIColor.orange, UIColor.yellow, UIColor.green, UIColor.init(red: 173/255, green: 216/255, blue: 230/255, alpha: 1), UIColor.blue, UIColor.purple, UIColor.lightGray, UIColor.brown, UIColor.black, UIColor.white]
    
    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //DATABASE RECIEVE
        let routeModel = RouteRecieveModel()
        routeModel.delegate = self
        routeModel.downloadItems()
        
        getItemsForCurrentRope()
        routeTableView.reloadData()
        
        if(!user[0].4) {
            button_Add.isHidden = true
        }
        
        //Shadows
        leftButton.layer.shadowColor = UIColor.black.cgColor
        leftButton.layer.shadowOpacity = 0.5
        leftButton.layer.shadowOffset = CGSize.zero
        leftButton.layer.shadowRadius = 10
        
        rightButton.layer.shadowColor = UIColor.black.cgColor
        rightButton.layer.shadowOpacity = 0.5
        rightButton.layer.shadowOffset = CGSize.zero
        rightButton.layer.shadowRadius = 10
        
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.5
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 10
        
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOpacity = 0.5
        bottomBar.layer.shadowOffset = CGSize.zero
        bottomBar.layer.shadowRadius = 10
        
        let circleColor = ImageTransformer.getImageWithColor(color: UIColor.white, size: routesCircleGraphic.frame.size)
        
        routesCircleGraphic.image = ImageTransformer.maskRoundedImage(image: circleColor, radius: Float(routesCircleGraphic.frame.width/2))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func itemsDownloaded(routeItems: NSArray) {
        feedItems = routeItems
        itemsAll = [(String, String, String, UIColor, String, Int)]()
        
        for i in 0 ..< feedItems.count {
            let route = feedItems[i] as! RouteModel
            
            var routeColor : UIColor
            if(route.color == "Red") {
                routeColor = colorArray[0]
            } else if(route.color == "Pink") {
                routeColor = colorArray[1]
            } else if(route.color == "Orange") {
                routeColor = colorArray[2]
            } else if(route.color == "Yellow") {
                routeColor = colorArray[3]
            } else if(route.color == "Green") {
                routeColor = colorArray[4]
            } else if(route.color == "Light Blue") {
                routeColor = colorArray[5]
            } else if(route.color == "Blue") {
                routeColor = colorArray[6]
            } else if(route.color == "Purple") {
                routeColor = colorArray[7]
            } else if(route.color == "Gray") {
                routeColor = colorArray[8]
            } else if(route.color == "Brown") {
                routeColor = colorArray[9]
            } else if(route.color == "Black") {
                routeColor = colorArray[10]
            } else {
                routeColor = colorArray[11]
            }
            
            var ropeNum = 0
            if(route.rope == "E") { ropeNum = 11 }
            else if(route.rope == "W") { ropeNum = 12 }
            else { ropeNum = Int(route.rope!)! }
            
            itemsAll.append((route.name!, route.setter!, route.rating!, routeColor, route.overlay!, ropeNum))
        }
    }
    
    //Number of rows in the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsRope.count * 2
    }
    
    //Sets up the cell in the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row % 2 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath) as! routeTableViewCell
            
            cell.routeName.text = itemsRope[indexPath.row/2].0
            cell.routeSetter.text = itemsRope[indexPath.row/2].1
            cell.routeRating.text = itemsRope[indexPath.row/2].2
            
            let colorImage = ImageTransformer.getImageWithColor(color: itemsRope[indexPath.row/2].3, size: cell.routeImage.frame.size)
            
            cell.routeImage.image = ImageTransformer.maskRoundedImage(image: colorImage, radius: Float(CGFloat(cell.routeImage.frame.width/2)))
            
            //Choose Overlay
            if(!setOrigionalSize) {
                origionalSize = cell.routeOverlay.frame.size
                origionalPoint = cell.routeOverlay.frame.origin
                setOrigionalSize = true
            }
            
            cell.routeOverlay.frame.size = origionalSize
            cell.routeOverlay.frame.origin = origionalPoint
            
            if(itemsRope[indexPath.row/2].4 == "nil") {
                //Dont do anything
                cell.routeOverlay.image = nil
            } else if(itemsRope[indexPath.row/2].4 == "Celtic") {
                cell.routeOverlay.image = UIImage(named: "Celtic_Knot_Edit_2.png")
            } else if(itemsRope[indexPath.row/2].4 == "YinYang") {
                cell.routeOverlay.image = UIImage(named: "Yin_yang.png")
            } else if(itemsRope[indexPath.row/2].4 == "MoonAndStars") {
                cell.routeOverlay.image = UIImage(named: "MoonAndStars.png")
            } else if(itemsRope[indexPath.row/2].4 == "Camo") {
                cell.routeOverlay.frame.size = cell.routeImage.frame.size
                cell.routeOverlay.frame.origin = cell.routeImage.frame.origin
                cell.routeOverlay.image = ImageTransformer.maskRoundedImage(image: UIImage(named: "Camo_Overlay_Circle.png")!, radius: Float(cell.routeOverlay.frame.width/2))
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarSpace", for: indexPath) as! spaceTableViewCell
            return cell
        }
    }
    
    //Change Height of Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row % 2 == 0) {
            return routeTableView.rowHeight
        } else {
            return 10
        }
    }
    
    //Remove Rows from TableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            
            //DATABASE SEND
            
            //Refresh
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(user[0].4) {
            return true
        } else {
            return false
        }
    }
    
    //Adds new route to database
    @IBAction func addRoute(sender: UIButton) {
        performSegue(withIdentifier: "RockWallToCreateRoute", sender: self)
    }
    
    //Change Rope
    @IBAction func leftButton(sender: UIButton) {
        if(currentRoute > 0) {
            currentRoute -= 1
            currentRouteLabel.text = ropes[currentRoute]
            getItemsForCurrentRope()
            routeTableView.reloadData()
        }
    }
    
    @IBAction func rightButton(sender: UIButton) {
        if(currentRoute < ropes.count - 1) {
            currentRoute += 1
            currentRouteLabel.text = ropes[currentRoute]
            getItemsForCurrentRope()
            routeTableView.reloadData()
        }
    }
    
    //Switches the array to contain the items only in the correct rope
    func getItemsForCurrentRope() {
        
        itemsRope.removeAll()
        
        var i = 0;
        
        while(i < itemsAll.count) {
            if(itemsAll[i].5 == Int(ropes[currentRoute])) {
                itemsRope.append(itemsAll[i]);
            }
            i += 1
        }
    }
    
    //Segues
    @IBAction func toGallary(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToGallary", sender: sender)
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToNews", sender: sender)
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        UIApplication.shared.open(NSURL(string: "https://wellness.okstate.edu/programs/outdoor-adventure") as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToCurrentlyClimbing", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RockWallToGallary") {
            let destinationVC = segue.destination as! MyGalleryViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "RockWallToNews") {
            let destinationVC = segue.destination as! MainViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "RockWallToCurrentlyClimbing") {
            let destinationVC = segue.destination as! CurrentlyClimbingViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "RockWallToCreateRoute") {
            let destinationVC = segue.destination as! CreateRouteViewController
            destinationVC.user = self.user
        }

    }
}
