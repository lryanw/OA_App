//
//  NewsRemoveRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/12/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class NewsRemoveRequest: NSObject, URLSessionDataDelegate {
    
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    var urlPath : String!
    
    var imagePath : String!
    
    init(newsDate: String, newsText: String) {
        
        urlPath = "http://dasnr58.dasnr.okstate.edu/NewsRemoveRequest.php?NewsDate=" + newsDate + "&NewsText=" + newsText.replacingOccurrences(of: " ", with: "_")
    }
    
    override init() { }
    
    func downloadItems() {
        
        let url : URL = URL(string: urlPath)!
        
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    func removeImageFromServer() {
        
        //Dont delete this file
        if(imagePath == "0.jpg") { return }
        
        let url : URL = URL(string: "http://dasnr58.dasnr.okstate.edu/DeleteFile.php?FileName=" + imagePath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
        
    }
    
    func removeImageFromServer(fileName: String) {
        
        //Dont delete this file
        if(fileName == "0.jpg") { return }
        
        let url : URL = URL(string: "http://dasnr58.dasnr.okstate.edu/DeleteFile.php?FileName=" + fileName)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
        
    }
    
    func deleteOldPosts() {
        
        let url : URL = URL(string: "http://dasnr58.dasnr.okstate.edu/DeleteOldNews.php")!
        
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
}
