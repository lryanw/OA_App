//
//  MainViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/9/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView_News: UITableView!
    
    //Tool Bar Buttons (Navigation)
    @IBOutlet weak var button_Gallery: UIBarButtonItem!
    @IBOutlet weak var button_RockWall: UIBarButtonItem!
    @IBOutlet weak var button_Calendar: UIBarButtonItem!
    @IBOutlet weak var button_Info: UIBarButtonItem!
    
    var items: [(String, String, UIImage, String, UIImage)] = [
        ("Outdoor Adventure", "Day 1", UIImage(named:"ic_launcher.png")!, "OMG OMG OMG", UIImage(named: "background_2.jpg")!),
        ("Outdoor Adventure", "Day 2", UIImage(named:"ic_launcher.png")!, "IMNJHNSDFJHDSLFJ SDLFJHSDFJHSDLFJH", UIImage(named: "background_2.jpg")!),
        ("Outdoor Adventure", "Day 3", UIImage(named:"ic_launcher.png")!, "IMG IMSDFKJ IODMDJNSFO ISDFLKNSDFL IDMSFLS", UIImage(named: "background_2.jpg")!)
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of rows in the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    //Sets up the cell in the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell_NewsTableViewCell;
        
        //Set Cell Up
        cell.news_Profile.text = items[indexPath.row].0;
        cell.news_Date.text = items[indexPath.row].1;
        cell.news_ProfileImage.image = items[indexPath.row].2;
        cell.news_Text.text = items[indexPath.row].3;
        cell.news_Image.image = items[indexPath.row].4;
        
        //Resize TextView Height
        let contentSize = cell.news_Text.sizeThatFits(cell.news_Text.bounds.size);
        var frame = cell.news_Text.frame;
        frame.size.height = contentSize.height;
        cell.news_Text.frame = frame;
        
        //Resize ImageView Height
        let imageWidth = items[indexPath.row].4.size.width;
        let imageHeight = items[indexPath.row].4.size.height;
        let newHeight = (tableView_News.frame.width * imageHeight)/imageWidth;
        
        cell.news_Image.frame.size = CGSize(width: tableView_News.frame.width, height: newHeight)
        
        return cell;
    }
    
    //Change Height of Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //Resize ImageView Height
        let imageWidth = items[indexPath.row].4.size.width;
        let imageHeight = items[indexPath.row].4.size.height;
        let newHeight = (tableView_News.frame.width * imageHeight)/imageWidth;
        
        return tableView_News.rowHeight + newHeight;
    }
    
    //Segues
    @IBAction func toGallery(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToGallery", sender: sender)
    }
    
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToRockWall", sender: sender);
    }
    
    @IBAction func toCalendar(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToCalendar", sender: sender);
    }
    
    @IBAction func toInfo(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToInfo", sender: sender);
    }
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToCurrentlyClimbing", sender: sender);
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
