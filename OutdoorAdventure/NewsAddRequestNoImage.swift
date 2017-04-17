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
    var urlAddPath : String = "http://dasnr58.dasnr.okstate.edu/NewsAddRequest.php"
    
    var imagePath : String!
    
    var email : String!
    var newsDate : String!
    var newsText : String!
    
    //THIS VARIABLE DETERMINES HOW MANY POSTS ON NEWS ARE ALLOWED
    var maxPostCount = 10
    
    init(email: String, newsDate: String, newsText: String) {
        self.email = email
        self.newsDate = newsDate
        self.newsText = newsText.replacingOccurrences(of: " ", with: "_")
    }
    
    func downloadItems() {
        
        urlAddPath = urlAddPath + "?Email=" + email + "&NewsDate=" + newsDate + "&NewsText=" + newsText + "&ImagePath=0.jpg"
        
        let url : URL = URL(string: urlAddPath)!
        
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
}
