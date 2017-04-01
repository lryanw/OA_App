//
//  ImageRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol ImageModelProtocol: class {
    func itemsDownloaded(imageItems: NSArray)
}

class ImageRecieveModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : ImageModelProtocol!
    
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
        let imageArray : NSMutableArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let image = ImageModel()
            
            if let imagePath = jsonElement["ImagePath"] as? String {
                
                image.imagePath = imagePath
            }
            imageArray.add(image)
        }
        
        //This may be wrong
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.delegate.itemsDownloaded(imageItems: imageArray)
            }
        }
    }
}
