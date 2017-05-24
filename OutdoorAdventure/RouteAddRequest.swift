//
//  RouteAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class RouteAddRequest: NSObject, URLSessionDataDelegate {
    
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/RouteAddRequest.php"
    
    init(color: String, overlay: String, name: String, rating: String, setter: String, rope: String) {
        
        //Fixes Issues with Naming
        let tempSetter = setter.replacingOccurrences(of: " ", with: "_")
        let tempName = name.replacingOccurrences(of: " ", with: "_")
        let tempRating = rating.replacingOccurrences(of: "+", with: "_2")
        
        urlPath = urlPath + "?Color=" + color + "&Overlay=" + overlay + "&Name=" + tempName + "&Rating=" + tempRating + "&Setter=" + tempSetter + "&Rope=" + rope
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

/*
 
 CHARACTER REPLACEMENT CHART
 
 ' -> _1
 + -> _2

 */
