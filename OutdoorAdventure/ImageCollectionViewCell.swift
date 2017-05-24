//
//  ImageCollectionViewCell.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/22/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewForImages: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    var imageSize : CGSize!
    
    func getImage(path: String) {
        cellImage.downloadedFrom(url: URL(string: "http://dasnr58.dasnr.okstate.edu/Images/" + path)!, sourceCell: self)
        cellImage.contentMode = .scaleToFill
    }
    
    override func awakeFromNib() {
        cellImage.image = UIImage.gif(name: "loadGif")
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, sourceCell: ImageCollectionViewCell, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
                sourceCell.imageSize = image.size
                sourceCell.cellImage.contentMode = .scaleAspectFill
                self.animate()
            }
        }.resume()
    }
    
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
