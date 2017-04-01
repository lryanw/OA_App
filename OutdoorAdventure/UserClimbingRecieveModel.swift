//
//  UserClimbingRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol UserClimbingModelProtocol: class {
    func itemsDownloaded(imageItems: NSArray)
}

class UserClimbingRecieveModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : UserClimbingModelProtocol!
    
    var data : NSMutableData = NSMutableData()
    
    //This points to the PHP service
    let urlPath : String = ""
    
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
        var jsonResult : NSMutableArray = NSMutableArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: self.data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSMutableArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement : NSDictionary = NSDictionary()
        let userClimbingArray : NSMutableArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let user = UserClimbingModel()
            
            if let firstName = jsonElement["FirstName"] as? String,
                let lastName = jsonElement["LastName"] as? String,
                let email = jsonElement["Email"] as? String,
                let profileImage = jsonElement["ProfileImage"] as? Int,
                let startHour = jsonElement["StartHour"] as? Int,
                let startMin = jsonElement["StartMin"] as? Int,
                let endHour = jsonElement["EndHour"] as? Int,
                let endMin = jsonElement["EndMin"] as? Int {
                
                user.firstName = firstName
                user.lastName = lastName
                user.email = email
                user.profileImage = profileImage
                user.startHour = startHour
                user.startMin = startMin
                user.endHour = endHour
                user.endMin = endMin
            }
            userClimbingArray.add(user)
        }
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(imageItems: userClimbingArray)
            }
        }
    }
}
