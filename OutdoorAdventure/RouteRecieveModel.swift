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
                            var rating = jsonElement["Rating"] as! String
                            let overlay = jsonElement["Overlay"] as! String
                            let rope = jsonElement["Rope"] as! String
                            
                            //Fix unusable characters
                            name = name.replacingOccurrences(of: "_", with: " ")
                            setter = setter.replacingOccurrences(of: "_", with: " ")
                            rating = rating.replacingOccurrences(of: "_2", with: "+")
                            
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
        
}

/*
 
 CHARACTER REPLACEMENT CHART
 
 ' -> _1
 + -> _2
 
 */
