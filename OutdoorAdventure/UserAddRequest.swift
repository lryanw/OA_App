//
//  UserAddRequest.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 4/1/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol UserAddModelProtocol: class {
    func itemsDownloaded(userItems: NSArray)
}

class UserAddRequest: NSObject, URLSessionDataDelegate {
    
    weak var delegate : UserAddModelProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/UserAddRequest.php"
    
    init(firstName: String, lastName: String, email: String, password: String, profileImage: Int, isEmployee: Bool) {
        urlPath = urlPath + "?FirstName=" + firstName + "&LastName=" + lastName + "&Email=" + email + "&Password=" + password + "&ProfileImage=\(profileImage)&IsEmployee=0"
    }
    
    func downloadItems() {
        let url : URL = URL(string: urlPath)!
        print(url)
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
}
