//
//  UserClimbingRemoveRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/8/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class UserClimbingRemoveRequest: NSObject, URLSessionDataDelegate {
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/UserClimbingRemoveRequest.php"
    
    init(endHour: Int, endMin: Int) {
        urlPath = urlPath + "?EndHour=\(endHour)&EndMin=\(endMin)"
    }
    
    func downloadItems() {
        print(urlPath)
        let url : URL = URL(string: urlPath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
}
