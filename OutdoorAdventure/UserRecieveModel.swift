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
        /*
        let url : URL = URL(string: urlPath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
     
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        
        task.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("HERE1")
        self.data.append(data)
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
        let userArray : NSMutableArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let user = UserModel()
            
            if let firstName = jsonElement["FirstName"] as? String,
                let lastName = jsonElement["LastName"] as? String,
                let email = jsonElement["Email"] as? String,
                let profileImage = jsonElement["ProfileImage"] as? Int,
                let isEmployee = jsonElement["IsEmployee"] as? String {
                
                user.firstName = firstName
                user.lastName = lastName
                user.email = email
                user.profileImage = profileImage
                user.isEmployee = isEmployee
            }
            userArray.add(user)
        }
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(userItems: userArray)
            }
        }
    }*/
}
