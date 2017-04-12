//
//  NewsRecieveModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/23/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

protocol NewsModelProtocol: class {
    func itemsDownloaded(newsItems: NSArray)
}

class NewsRecieveModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate : NewsModelProtocol!
    
    var listData : [[String: AnyObject]]!
    
    //This points to the PHP service
    let urlPath : String = "http://dasnr58.dasnr.okstate.edu/NewsRequest.php"
    
    func downloadItems() {
        let urlRequest = URL(string: urlPath)
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print(error.debugDescription)
            } else {
                let newsArray : NSMutableArray = NSMutableArray()
                
                do {
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    OperationQueue.main.addOperation {
                        for i in 0 ..< self.listData.count {
                            
                            let news = NewsModel()
                            
                            let jsonElement = self.listData[i]
                            
                            let firstName = jsonElement["FirstName"] as! String
                            let lastName = jsonElement["LastName"] as! String
                            let date = jsonElement["PostDate"] as! String
                            let profileImage = Int(jsonElement["ProfileImage"] as! String)
                            let newsText = jsonElement["NewsText"] as! String
                            let imagePath = jsonElement["ImagePath"] as! String
                                
                            news.firstName = firstName
                            news.lastName = lastName
                            news.date = date
                            news.profileImage = profileImage
                            news.newsText = newsText
                            news.imagePath = imagePath
                            
                            news.getImage()
                                                            
                            newsArray.add(news)
                        }
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.delegate.itemsDownloaded(newsItems: newsArray)
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
    }
}
