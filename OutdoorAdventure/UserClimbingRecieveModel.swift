//
//  UserClimbingRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol UserClimbingModelProtocol: class {
    func itemsDownloaded(userClimbingItems: NSArray)
}

class UserClimbingRecieveModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : UserClimbingModelProtocol!
        
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    let urlPath : String = "http://dasnr58.dasnr.okstate.edu/UserClimbingRequest.php"
    
    func downloadItems() {
        let urlRequest = URL(string: urlPath)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let userClimbingArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let user = UserClimbingModel()
                            
                            let jsonElement = self.listData[i]
                            
                            let firstName = jsonElement["FirstName"] as! String
                            let lastName = jsonElement["LastName"] as! String
                            let email = jsonElement["Email"] as! String
                            let profileImage = Int(jsonElement["ProfileImage"] as! String)
                            let startHour = Int(jsonElement["StartHour"] as! String)
                            let startMin = Int(jsonElement["StartMin"] as! String)
                            let endHour = Int(jsonElement["EndHour"] as! String)
                            let endMin = Int(jsonElement["EndMin"] as! String)
                                
                            user.firstName = firstName
                            user.lastName = lastName
                            user.email = email
                            user.profileImage = profileImage
                            user.startHour = startHour
                            user.startMin = startMin
                            user.endHour = endHour
                            user.endMin = endMin
                            
                            userClimbingArray.add(user)
                            
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.delegate.itemsDownloaded(userClimbingItems: userClimbingArray)
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}
