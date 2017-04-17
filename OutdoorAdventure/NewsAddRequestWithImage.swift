//
//  NewsAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class NewsAddRequestWithImage: NSObject, URLSessionDataDelegate {
        
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/NewsAddRequest.php"
    
    var imagePath : String!
        
    //THIS VARIABLE DETERMINES HOW MANY POSTS ON NEWS ARE ALLOWED
    var maxPostCount = 10
    
    init(email: String, newsDate: String, newsText: String) {
        
        let newsTextTemp = newsText.replacingOccurrences(of: " ", with: "_")
        
        urlPath = urlPath + "?Email=" + email + "&NewsDate=" + newsDate + "&NewsText=" + newsTextTemp + "&ImagePath="
    }
    
    func downloadItems() {
        let url : URL = URL(string: urlPath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    //Deletes old news posts, only allows 10
    func deleteOldPosts() {
        
        let url : URL = URL(string: "http://dasnr58.dasnr.okstate.edu/DeleteOldNews.php")!
        
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    //Deletes old images, when old posts are deleted
    func deleteOldImage(imageName: String) {
        
        let url : URL = URL(string: "http://dasnr58.dasnr.okstate.edu/DeleteFile.php?FileName=" + imageName)!
        
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    func getLastImagePath() {
        let urlRequest = URL(string: "http://dasnr58.dasnr.okstate.edu/GetLastImageName.php")
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let imageArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let image = ImageModel()
                            
                            let jsonElement = self.listData[i]
                            
                            let imagePath = jsonElement["ImagePath"] as! String

                            image.imagePath = imagePath
                            
                            imageArray.add(image)
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            let image = imageArray[0] as! ImageModel
                            self.imagePath = image.imagePath
                            
                            //Gets the name of the last image (Which should be numbered) and increases the number by one
                            var imageName : Int!
                            
                            //Removes the file type
                            if(self.imagePath.contains(".jpg")) {
                                self.imagePath = self.imagePath.replacingOccurrences(of: ".jpg", with: "")
                            } else if(self.imagePath.contains(".png")) {
                                self.imagePath = self.imagePath.replacingOccurrences(of: ".jpg", with: "")
                            }
                            imageName = Int(self.imagePath)! + 1
                            self.urlPath = self.urlPath + "\(imageName)"
                            
                            //Delete old image
                            self.deleteOldImage(imageName: image.imagePath!)
                            
                            //Now the path has been created, add it to sql
                            self.downloadItems()
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}
