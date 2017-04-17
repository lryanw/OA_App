//
//  ImageRemoveRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/14/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class ImageRemoveRequest: NSObject, URLSessionDataDelegate {
        
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/ImageRemoveRequest.php"
    var imagePath : String!
    
    init(imagePath: String) {
        urlPath = urlPath + "?ImagePath=" + imagePath
        self.imagePath = imagePath
    }
    
    func downloadItems() {
        let url : URL = URL(string: urlPath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    func removeImageFromServer() {
        let url : URL = URL(string: "http://dasnr58.dasnr.okstate.edu/DeleteFile.php?FileName=" + imagePath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()

    }
}
