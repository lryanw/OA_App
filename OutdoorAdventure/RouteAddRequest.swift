//
//  RouteAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol RouteAddProtocol: class {
    func itemsDownloaded(routeItems: NSArray)
}

class RouteAddRequest: NSObject, URLSessionDataDelegate {
    
    weak var delegate : RouteAddProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    var urlPath : String = ""
    
    init(color: String, overlay: String, name: String, rating: String, setter: String, rope: String) {
        urlPath = urlPath + "?Color=" + color + "&Overlay=" + overlay + "&Name=" + name + "&Rating=" + "&Setter=" + "&Rope=" + rope
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
        
        let routeArray : NSMutableArray = NSMutableArray()
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(routeItems: routeArray)
            }
        }
    }
}
