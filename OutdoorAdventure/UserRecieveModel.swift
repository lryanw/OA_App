//
//  UserRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol UserModelProtocol: class {
    func itemsDownloaded(userItems: NSArray)
}

class UserRecieveModel: NSObject, URLSessionDataDelegate, URLSessionTaskDelegate, URLSessionDelegate {
    
    weak var delegate : UserModelProtocol!
    
    //var data : NSMutableData = NSMutableData()
    
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    var urlPath : String = "http://dasnr58.dasnr.okstate.edu/UserRequest.php"
    
    init(pEmail: String, pPassword: String) {
        urlPath = urlPath + "?Email=" + pEmail + "&Password=" + pPassword
    }
    
    func downloadItems() {
        
        let urlRequest = URL(string: urlPath)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let userArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let user = UserModel()
                            
                            let jsonElement = self.listData[i]
                            
                            let firstName = jsonElement["FirstName"] as! String
                            let lastName = jsonElement["LastName"] as! String
                            let email = jsonElement["Email"] as! String
                            let profileImage = Int(jsonElement["ProfileImage"] as! String)
                            let isEmployeeNum = Int(jsonElement["IsEmployee"] as! String)
                            
                            var isEmployee : Bool
                            
                            if(isEmployeeNum == 1) {
                                isEmployee = true
                            } else {
                                isEmployee = false
                            }
                                
                            user.firstName = firstName
                            user.lastName = lastName
                            user.email = email
                            user.profileImage = profileImage
                            user.isEmployee = isEmployee
                            
                            userArray.add(user)
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.delegate.itemsDownloaded(userItems: userArray)
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}
