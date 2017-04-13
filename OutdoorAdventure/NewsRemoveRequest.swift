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
    
    func downloadItems() {
        
        let url : URL = URL(string: urlPath)!
        
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
}
