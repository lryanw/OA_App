//
//  ImageCollectionViewCell.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/22/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewForImages: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        
    }
    
    func getImage(path: String) {
        cellImage.downloadedFrom(url: URL(string: "http://dasnr58.dasnr.okstate.edu/Images/" + path)!)
        cellImage.contentMode = .scaleToFill
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
}
