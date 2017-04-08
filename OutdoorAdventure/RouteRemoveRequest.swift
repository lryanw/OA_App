//
//  RouteRemoveRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/8/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class RouteRemoveRequest: NSObject, URLSessionDataDelegate {
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/RouteRemoveRequest.php"
    
    init(name: String) {
        
        //Fixes Issues with Naming
        let tempName = name.replacingOccurrences(of: " ", with: "_")
        
        urlPath = urlPath + "?Name=" + tempName
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
