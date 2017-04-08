//
//  UserClimbingAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class UserClimbingAddRequest: NSObject, URLSessionDataDelegate {
        
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/UserClimbingAddRequest.php"
    
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
}
