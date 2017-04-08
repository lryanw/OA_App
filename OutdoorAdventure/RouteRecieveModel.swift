//
//  RouteRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol RouteModelProtocol: class {
    func itemsDownloaded(routeItems: NSArray)
}

class RouteRecieveModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : RouteModelProtocol!
    
    var data : NSMutableData = NSMutableData()
    
     var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    let urlPath : String = "http://dasnr58.dasnr.okstate.edu/RouteRequest.php"
    
    func downloadItems() {
        let urlRequest = URL(string: urlPath)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let routeArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let route = RouteModel()
                            
                            let jsonElement = self.listData[i]
                            
                            var name = jsonElement["Name"] as! String
                            var setter = jsonElement["Setter"] as! String
                            let color = jsonElement["Color"] as! String
                            let rating = jsonElement["Rating"] as! String
                            let overlay = jsonElement["Overlay"] as! String
                            let rope = jsonElement["Rope"] as! String
                            
                            name = name.replacingOccurrences(of: "_", with: " ")
                            setter = setter.replacingOccurrences(of: "_", with: " ")
                            
                            route.name = name
                            route.setter = setter
                            route.color = color
                            route.rating = rating
                            route.overlay = overlay
                            route.rope = rope
                            
                            routeArray.add(route)
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.delegate.itemsDownloaded(routeItems: routeArray)
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
    
    //THIS IS NOT GETTING CALLED
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
        let routeArray : NSMutableArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let route = RouteModel()
            
            if let name = jsonElement["Name"] as? String,
                let setter = jsonElement["Setter"] as? String,
                let color = jsonElement["Color"] as? String,
                let rating = jsonElement["Rating"] as? String,
                let overlay = jsonElement["Overlay"] as? String,
                let rope = jsonElement["Rope"] as? String{
                
                route.name = name
                route.setter = setter
                route.color = color
                route.rating = rating
                route.overlay = overlay
                route.rope = rope
            }
            routeArray.add(route)
        }
        
        print(routeArray.count)
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(routeItems: routeArray)
            }
        }
    }*/
}
