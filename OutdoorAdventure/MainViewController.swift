//
//  MainViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/9/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsModelProtocol {

    //To add new news
    @IBOutlet weak var button_Add: UIButton!
    
    //ToolBars for shadows
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    //TableView
    @IBOutlet weak var tableView_News: UITableView!
    
    //Tool Bar Buttons (Navigation)
    @IBOutlet weak var button_Gallery: UIBarButtonItem!
    @IBOutlet weak var button_RockWall: UIBarButtonItem!
    @IBOutlet weak var button_Info: UIBarButtonItem!
    
    //For image viewer
    var imageToPass : UIImage!
    
    //Profile Name, Post Date, ProfileImage, News Text, News Image
    var items: [(String, String, Int, String, UIImage)] = [
        ("Outdoor Adventure", "Day 1", 0, "OMG OMG OMG", UIImage(named: "background_2.jpg")!),
        ("Outdoor Adventure", "Day 2", 0, "IMNJHNSDFJHDSLFJ SDLFJHSDFJHSDLFJH", UIImage(named: "background_1.jpg")!),
        ("Outdoor Adventure", "Day 3", 0, "IMG IMSDFKJ IODMDJNSFO ISDFLKNSDFL IDMSFLS", UIImage(named: "background_2.jpg")!)
    ]
    
    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        // Do any additional setup after loading the view.

        //DATABASE RECIEVE
        let newsModel = NewsRecieveModel()
        newsModel.delegate = self
        //newsModel.downloadItems()
        
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
    
    func itemsDownloaded(newsItems userItems: NSArray) {
        let feedItems : NSArray = userItems
        items = [(String, String, Int, String, UIImage)]()
        
        //Change NSArray to items Tuple
        for i in 0 ..< feedItems.count {
            let news = feedItems[i] as! NewsModel
            
            let userName = news.firstName! + " " + news.lastName!
            
            //Get Image from Image Path
            if let url = NSURL(string: news.imagePath!) {
                if let data = NSData(contentsOf: url as URL) {
                    let currImage = UIImage(data: data as Data)
                    
                    items.append((userName, news.date!, news.profileImage!, news.newsText!, currImage!))
                }        
            }
        }
    }
    
    //Number of rows in the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count * 2
    }
    
    //Sets up the cell in the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row % 2 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell_NewsTableViewCell
            
            //Set Cell Up
            cell.news_Profile.text = items[indexPath.row/2].0
            cell.news_Date.text = items[indexPath.row/2].1
            cell.news_ProfileImage.image = UIImage(named: "\(items[indexPath.row/2].2).jpg")
            if(items[indexPath.row/2].2 == 0) {
                cell.news_ProfileImage.layer.borderWidth = 1
                cell.news_ProfileImage.layer.borderColor = UIColor.black.cgColor
            }
            cell.news_Text.text = items[indexPath.row/2].3
            cell.news_Image.image = items[indexPath.row/2].4
            
            //Resize TextView Height
            let contentSize = cell.news_Text.sizeThatFits(cell.news_Text.bounds.size)
            var frame = cell.news_Text.frame
            frame.size.height = contentSize.height
            cell.news_Text.frame = frame
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.news_Image.isUserInteractionEnabled = true
            cell.news_Image.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarSpace", for: indexPath) as! spaceTableViewCell
            return cell
        }
    }
    
    //Change Height of Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row % 2 == 0) {
            
            //Resize ImageView Height
            let imageWidth = items[indexPath.row/2].4.size.width
            let imageHeight = items[indexPath.row/2].4.size.height
            let newHeight = (tableView_News.frame.width * imageHeight)/imageWidth
            
            let currentString = items[indexPath.row/2].3
            
            return tableView_News.rowHeight + newHeight + currentString.heightWithConstrainedWidth(width: 380, font: UIFont.systemFont(ofSize: 17)) + (20 * tableView_News.frame.width)/414 ///20
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
    
    //Go to imageViewer
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tempView = tapGestureRecognizer.view as! UIImageView
        imageToPass = tempView.image
        
        performSegue(withIdentifier: "NewsToImageViewer", sender: self)
    }
    
    //Segues
    @IBAction func toGallery(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToGallery", sender: sender)
    }
    
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToRockWall", sender: sender)
    }

    @IBAction func toInfo(sender: UIBarButtonItem) {
        UIApplication.shared.open(NSURL(string: "https://wellness.okstate.edu/programs/outdoor-adventure") as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func toCurrentlyClimbing(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToCurrentlyClimbing", sender: sender)
    }
    
    @IBAction func createNews(sender: UIButton) {
        performSegue(withIdentifier: "NewsToCreateNews", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "NewsToImageViewer") {
            let destinationVC = segue.destination as! ZoomedPhotoUIViewController
            destinationVC.currImage = imageToPass
            destinationVC.senderString = "News"
            destinationVC.user = self.user
        } else if(segue.identifier == "NewsToGallery") {
            let destinationVC = segue.destination as! MyGalleryViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "NewsToRockWall") {
            let destinationVC = segue.destination as! RockWallViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "NewsToCurrentlyClimbing") {
            let destinationVC = segue.destination as! CurrentlyClimbingViewController
            destinationVC.user = self.user
        } else if(segue.identifier == "NewsToCreateNews") {
            let destinationVC = segue.destination as! CreateNewsViewController
            destinationVC.user = self.user
        }
    }
}

//To get size of a label based on a string
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
