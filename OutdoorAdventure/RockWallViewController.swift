//
//  RockWallViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/13/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit
import QuartzCore

class RockWallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Toolbars for shadows
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var topBar: UIToolbar!
    
    //Routes Graphic
    @IBOutlet weak var routesCircleGraphic: UIImageView!
    var currentRoute = 0;
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var currentRouteLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //TableView
    @IBOutlet weak var routeTableView: UITableView!
    
    //Route Name, Setter, Difficulty, Color, Symbol
    var items: [(String, String, String, UIColor, String)] = [("Up Up And Away", "Ryan Lee", "I+", UIColor.red, "nil"), ("Up Up And Away", "Ryan Lee", "B", UIColor.yellow, "Celtic"), ("Up Up And Away", "Ryan Lee", "A-", UIColor.blue, "Camo")];
    
    var ropes = ["1","2","3","4","5","6","7","8","9","10","E","W"];
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Shadows
        leftButton.layer.shadowColor = UIColor.black.cgColor;
        leftButton.layer.shadowOpacity = 1;
        leftButton.layer.shadowOffset = CGSize.zero;
        leftButton.layer.shadowRadius = 10;
        
        rightButton.layer.shadowColor = UIColor.black.cgColor;
        rightButton.layer.shadowOpacity = 1;
        rightButton.layer.shadowOffset = CGSize.zero;
        rightButton.layer.shadowRadius = 10;
        
        topBar.layer.shadowColor = UIColor.black.cgColor;
        topBar.layer.shadowOpacity = 1;
        topBar.layer.shadowOffset = CGSize.zero;
        topBar.layer.shadowRadius = 10;
        
        bottomBar.layer.shadowColor = UIColor.black.cgColor;
        bottomBar.layer.shadowOpacity = 1;
        bottomBar.layer.shadowOffset = CGSize.zero;
        bottomBar.layer.shadowRadius = 10;
        
        let circleColor = ImageTransformer.getImageWithColor(color: UIColor.white, size: routesCircleGraphic.frame.size)
        
        routesCircleGraphic.image = ImageTransformer.maskRoundedImage(image: circleColor, radius: Float(routesCircleGraphic.frame.width/2));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of rows in the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count * 2;
    }
    
    //Sets up the cell in the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row % 2 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath) as! routeTableViewCell;
            
            cell.routeName.text = items[indexPath.row/2].0;
            cell.routeSetter.text = items[indexPath.row/2].1;
            cell.routeRating.text = items[indexPath.row/2].2;
            
            let colorImage = ImageTransformer.getImageWithColor(color: items[indexPath.row/2].3, size: cell.routeImage.frame.size)
            
            cell.routeImage.image = ImageTransformer.maskRoundedImage(image: colorImage, radius: Float(CGFloat(cell.routeImage.frame.width/2)))
            
            //Choose Overlay
            if(items[indexPath.row/2].4 == "nil") {
                //Dont do anything
            } else if(items[indexPath.row/2].4 == "Celtic") {
                cell.routeOverlay.frame.origin = CGPoint(x: cell.routeOverlay.frame.origin.x, y: cell.routeOverlay.frame.origin.y - (cell.routeOverlay.frame.height/11))
                cell.routeOverlay.image = UIImage(named: "Celtic_Knot_Edit.png");
            } else if(items[indexPath.row/2].4 == "YinYang") {
                cell.routeOverlay.image = UIImage(named: "Yin_yang.png")
            } else if(items[indexPath.row/2].4 == "MoonAndStars") {
                cell.routeOverlay.image = UIImage(named: "MoonAndStars.png");
            } else if(items[indexPath.row/2].4 == "Camo") {
                cell.routeOverlay.frame.size = cell.routeImage.frame.size;
                cell.routeOverlay.frame.origin = cell.routeImage.frame.origin;
                cell.routeOverlay.image = ImageTransformer.maskRoundedImage(image: UIImage(named: "Camo_Overlay_Circle.png")!, radius: Float(cell.routeOverlay.frame.width/2));
            }
            return cell;
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarSpace", for: indexPath) as! spaceTableViewCell;
            return cell;
        }
    }
    
    //Change Height of Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row % 2 == 0) {
            return routeTableView.rowHeight;
        } else {
            return 10;
        }
    }
    
    //Change Rope
    @IBAction func leftButton(sender: UIButton) {
        if(currentRoute > 0) {
            currentRoute -= 1;
            currentRouteLabel.text = ropes[currentRoute];
        }
    }
    
    @IBAction func rightButton(sender: UIButton) {
        if(currentRoute < ropes.count - 1) {
            currentRoute += 1;
            currentRouteLabel.text = ropes[currentRoute];
        }
    }
    
    //Segues
    @IBAction func toGallary(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToGallary", sender: sender);
    }
    
    @IBAction func toNews(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToNews", sender: sender)
    }
    
    @IBAction func toCalendar(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToCalendar", sender: sender);
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToInfo", sender: sender);
    }
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "RockWallToCurrentlyClimbing", sender: sender);
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
