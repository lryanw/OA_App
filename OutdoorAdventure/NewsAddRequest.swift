//
//  NewsAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol NewsAddModelProtocol: class {
    func itemsDownloaded(newsItems: NSArray)
}

class NewsAddModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : NewsAddModelProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    var urlPath : String = ""
    
    init(email: String, newsDate: String, newsText: String, imagePath: String) {
        urlPath = urlPath + "?FirstName=" + email + "&NewsDate=" + newsDate + "&NewsText=" + newsText + "&ImagePath=" + imagePath
    }
    
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

        let newsArray : NSMutableArray = NSMutableArray()
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(newsItems: newsArray)
            }
        }
    }
}
