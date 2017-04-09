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
    
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    let urlPath : String = "http://dasnr58.dasnr.okstate.edu/ImageRequest.php"
    
    func downloadItems() {
        let urlRequest = URL(string: urlPath)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let imageArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let imageModel = ImageModel()
                            
                            let jsonElement = self.listData[i]
                            
                            let imagePath = jsonElement["ImagePath"] as! String
                            
                            imageModel.imagePath = imagePath
                            
                            imageArray.add(imageModel)
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.delegate.itemsDownloaded(imageItems: imageArray)
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}
