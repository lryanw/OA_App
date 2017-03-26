//
//  NewsRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/23/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol NewsModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class NewsRecieveModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : NewsModelProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    let urlPath : String = ""
    
    func downloadItems() {
        let url : URL = URL(string: urlPath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed To Download Data")
        } else {
            print("Data Downloaded")
            self.parseJSON()
        }
    }
    
    func parseJSON() {
        var jsonResult : NSMutableArray = NSMutableArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: self.data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSMutableArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement : NSDictionary = NSDictionary()
        let newsArray : NSMutableArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let news = NewsModel()
            
            if let firstName = jsonElement["FirstName"] as? String,
                let lastName = jsonElement["LastName"] as? String,
                let date = jsonElement["Date"] as? String,
                let profileImage = jsonElement["ProfileImage"] as? Int,
                let newsText = jsonElement["NewsText"] as? String,
                let imagePath = jsonElement["ImagePath"] as? String {
                
                news.firstName = firstName
                news.lastName = lastName
                news.date = date
                news.profileImage = profileImage
                news.newsText = newsText
                news.imagePath = imagePath
            }
            newsArray.add(news)
        }
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(items: newsArray)
            }
        }
    }
}
