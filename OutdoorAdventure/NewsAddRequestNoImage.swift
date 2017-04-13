//
//  NewsAddRequestNoImage.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/12/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//


import Foundation

class NewsAddRequestNoImage: NSObject, URLSessionDataDelegate {
    
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/NewsAddRequest.php"
    
    var imagePath : String!
    
    var email : String!
    var newsDate : String!
    var newsText : String!
    var lastID : Int!
    
    init(email: String, newsDate: String, newsText: String) {
        self.email = email
        self.newsDate = newsDate
        self.newsText = newsText.replacingOccurrences(of: " ", with: "_")
    }
    
    func downloadItems() {
        
        urlPath = urlPath + "?ID=\(lastID!)&Email=" + email + "&NewsDate=" + newsDate + "&NewsText=" + newsText + "&ImagePath=0.jpg"
        
        let url : URL = URL(string: urlPath)!
                
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    //Do this 1st
    func getLastNewsID() {
        let urlRequest = URL(string: "http://dasnr58.dasnr.okstate.edu/GetLastNewsID.php")
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let idArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let jsonElement = self.listData[i]
                            
                            let lastID = Int(jsonElement["ID"] as! String)
                            idArray.add(lastID!)
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            var id : Int!
                            
                            if(idArray.count > 0) { id = idArray[0] as! Int }
                            else { id = 0 }
                            
                            self.lastID = id + 1
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
