//
//  UserClimbingAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol UserClimbingAddModelProtocol: class {
    func itemsDownloaded(imageItems: NSArray)
}

class UserClimbingAddRequest: NSObject, URLSessionDataDelegate {
    
    weak var delegate : UserClimbingAddModelProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    var urlPath : String = ""
    
    init(email: String, startHour: Int, startMin: Int, endHour: Int, endMin: Int) {
        urlPath = urlPath + "?Email=\(email)&StartHour=\(startHour)&StartMin=\(startMin)&EndHour=\(endHour)&EndMin=\(endMin)"
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

        let userClimbingArray : NSMutableArray = NSMutableArray()
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(imageItems: userClimbingArray)
            }
        }
    }
}
