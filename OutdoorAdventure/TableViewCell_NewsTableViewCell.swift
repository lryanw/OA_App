//
//  TableViewCell_NewsTableViewCell.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/11/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import UIKit

class TableViewCell_NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var news_ProfileImage: UIImageView!
    @IBOutlet weak var news_Profile: UILabel!
    @IBOutlet weak var news_Date: UILabel!
    @IBOutlet weak var news_Text: UILabel!
    @IBOutlet weak var news_Image: UIImageView!
    
    var imageSize : CGSize!
    
    override func awakeFromNib() {
        news_ProfileImage = ImageTransformer.roundImageView(imageView: news_ProfileImage)
    }
    
    func getImage(path: String) {
        news_Image.downloadedFrom(url: URL(string: "http://dasnr58.dasnr.okstate.edu/Images/" + path)!, newsCell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, newsCell: TableViewCell_NewsTableViewCell, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
                newsCell.imageSize = image.size
            }
        }.resume()
    }
}

