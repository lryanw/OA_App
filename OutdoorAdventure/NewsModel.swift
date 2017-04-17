//
//  NewsModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/23/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    
    var firstName : String?
    var lastName : String?
    var profileImage : Int?
    var date : String?
    var newsText : String?
    var imagePath : String?
    
    var image : UIImage?

    override init() {
        
    }
    
    init(fN: String, lN: String, pI: Int, d: String, nT: String, iP: String) {
        firstName = fN
        lastName = lN
        profileImage = pI
        date = d
        newsText = nT
        imagePath = iP
    }
    
    func getImage() {
        downloadImage(url: URL(string: "http://dasnr58.dasnr.okstate.edu/Images/" + imagePath!)!)
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = UIImage(data: data)
            }
        }
    }
}
