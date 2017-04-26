//
//  MainViewController.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/9/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsModelProtocol {

    //==========GLOBAL VARIABLES==========
    
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
    
    //Max number of posts in database
    //Will be 1 more than this
    var maxPosts : Int = 9
    
    //For image viewer
    var imageToPass : UIImage!
    var imageSizeToPass : CGSize!
    
    //Profile Name, Post Date, ProfileImage, News Text, News Image, News Image Path
    var items: [(String, String, Int, String, String, Bool, UIImage, String)] = []
    
    //First Name, Last Name, Email, ProfileImage, IsEmployee
    var user: [(String, String, String, Int, Bool)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        // Do any additional setup after loading the view.
        
        //DATABASE RECIEVE
        let newsModel = NewsRecieveModel()
        newsModel.delegate = self
        newsModel.downloadItems()
        
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
    
    //This is called from the cell once the image is downloaded from the server
    func setRowToReload(index: IndexPath, image: UIImage) {
        items[index.row/2].5 = true
        items[index.row/2].6 = image
    }
    
    //==========GET NEWS FROM DB==========
    
    func itemsDownloaded(newsItems userItems: NSArray) {
        let feedItems : NSArray = userItems
        
        items.removeAll()
        
        //Change NSArray to items Tuple
        for i in 0 ..< feedItems.count {
            let news = feedItems[i] as! NewsModel
            
            //DELETE OLD POSTS
            if(i > maxPosts) {
                let newsRem = NewsRemoveRequest()
                //Deletes old post from DB
                newsRem.deleteOldPosts()
                //Deletes image from server
                if(news.imagePath! != "0.jpg") {
                    newsRem.removeImageFromServer(fileName: news.imagePath!)
                }
                continue;
            }
            
            //Combine First and Last name
            let userName = news.firstName! + " " + news.lastName!
            
            //Cleans up date string
            for _ in 0 ..< 5 {
                news.date!.remove(at: news.date!.startIndex)
            }
            
            items.append((userName, news.date!.replacingOccurrences(of: "-", with: "/"), news.profileImage!, news.newsText!.replacingOccurrences(of: "_", with: " "), news.imagePath!, false, ImageTransformer.getImageWithColor(color: UIColor.clear, size: CGSize(width: 2, height: 2)), news.imagePath!))
        }
        
        tableView_News.reloadData()
    }
    
    //==========SET UP TABLE VIEW===========
    
    //Number of rows in the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count * 2
    }
    
    //Sets up the cell in the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row % 2 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell_NewsTableViewCell
            
            //Set Cell Up
            cell.cellIndex = indexPath
            
            cell.news_Profile.text = items[indexPath.row/2].0
            cell.news_Date.text = items[indexPath.row/2].1
            cell.news_ProfileImage.image = UIImage(named: "\(items[indexPath.row/2].2).jpg")
            if(items[indexPath.row/2].2 == 0) {
                cell.news_ProfileImage.layer.borderWidth = 1
                cell.news_ProfileImage.layer.borderColor = UIColor.black.cgColor
            }
            
            cell.news_Text.text = items[indexPath.row/2].3
            cell.tableView = tableView_News
            cell.source = self
            cell.news_ImagePath = items[indexPath.row/2].7
            
            //If has not loaded image
            if(items[indexPath.row/2].5 == false) { cell.getImage(path: items[indexPath.row/2].4)
            }
            //If has loaded image
            if(items[indexPath.row/2].5 == true) {
                cell.news_Image.image = items[indexPath.row/2].6
            }
            
            //Resize TextView Height
            let contentSize = cell.news_Text.sizeThatFits(cell.news_Text.bounds.size)
            var frame = cell.news_Text.frame
            frame.size.height = contentSize.height
            cell.news_Text.frame = frame
            
            //Allows image to be viewed in gallary
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.news_Image.isUserInteractionEnabled = true
            cell.news_Image.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarSpace", for: indexPath) as! spaceTableViewCell
            return cell
        }
    }
    
    //Animate cell on load
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.animate()
    }
    
    //Change Height of Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //If the image has not loaded yet
        if (indexPath.row % 2 == 0 && items[indexPath.row/2].5 == false) {
            
            let removeHeight = (50 * tableView_News.frame.width)/tableView_News.frame.height
            
            let currentString = items[indexPath.row/2].3
            
            return (tableView_News.rowHeight - removeHeight + currentString.heightWithConstrainedWidth(width: 380, font: UIFont.systemFont(ofSize: 17)) + (20 * tableView_News.frame.width)/414 - (55 * tableView_News.frame.width)/tableView_News.frame.height)
        
        //If the image has loaded
        } else if(indexPath.row % 2 == 0 && items[indexPath.row/2].5 == true) {
            
            //Resize ImageView Height
            let imageWidth = items[indexPath.row/2].6.size.width
            let imageHeight = items[indexPath.row/2].6.size.height
            let newHeight = (tableView_News.frame.width * imageHeight)/imageWidth
            
            let currentString = items[indexPath.row/2].3
            
            return (tableView_News.rowHeight  + currentString.heightWithConstrainedWidth(width: 380, font: UIFont.systemFont(ofSize: 17)) + newHeight - (78 * tableView_News.frame.width)/tableView_News.frame.height)
            
        } else {
            return 10
        }
    }
    
    //Remove Rows from TableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //Checks if employee
        if(editingStyle == UITableViewCellEditingStyle.delete && user[0].4 == true) {
            
            let cell = tableView_News.cellForRow(at: indexPath) as! TableViewCell_NewsTableViewCell
            
            let alertController = UIAlertController(title: "Delete Post?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in self.removeFromDB(cell: cell) }))
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //==========REMOVE FROM DATABASE===========
    
    func removeFromDB(cell: TableViewCell_NewsTableViewCell) {
        //DATABASE SEND
        let newsRemoveModel = NewsRemoveRequest(newsDate: cell.news_Date.text!, newsText: cell.news_Text.text!)
        newsRemoveModel.downloadItems()
        
        //If row has an image
        if(cell.news_Image.image != nil) {
            newsRemoveModel.imagePath = cell.news_ImagePath
            newsRemoveModel.removeImageFromServer()
        }
        
        //Refresh
        let newsModel = NewsRecieveModel()
        newsModel.delegate = self
        newsModel.downloadItems()
        
        tableView_News.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(user[0].4 && indexPath.row % 2 == 0) {
            return true
        } else {
            return false
        }
    }
    
    //Go to imageViewer
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tempView = tapGestureRecognizer.view as! UIImageView
        imageToPass = tempView.image
        imageSizeToPass = tempView.image!.size
        
        performSegue(withIdentifier: "NewsToImageViewer", sender: self)
    }
    
    //==========SEGUES===========
    
    @IBAction func toGallery(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToGallery", sender: sender)
    }
    
    @IBAction func toRockWall(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewsToRockWall", sender: sender)
    }

    @IBAction func toInfo(sender: UIBarButtonItem) {
        UIApplication.shared.open(NSURL(string: "https://wellness.okstate.edu/programs/outdoor-adventure")! as URL, options: [:], completionHandler: nil)
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
            destinationVC.currImageSize = imageSizeToPass
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

//Animates cell
extension UITableViewCell {
    func animate() {
        let view = self.contentView
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: { () -> Void in view.layer.opacity = 1 }, completion: nil)
    }
}

//Animates UImageView
extension UIImageView {
    func animate() {
        self.layer.opacity = 0.1
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: { () -> Void in self.layer.opacity = 1 }, completion: nil)
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
