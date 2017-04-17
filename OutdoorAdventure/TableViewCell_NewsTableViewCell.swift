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
    var news_ImagePath : String!
    
    var imageSize : CGSize!
    
    var cellIndex : IndexPath!
    
    var tableView : UITableView!
    var source : MainViewController!
    
    override func awakeFromNib() {
        news_ProfileImage = ImageTransformer.roundImageView(imageView: news_ProfileImage)
    }
    
    func getImage(path: String) {
        news_Image.downloadedFrom(url: URL(string: "http://dasnr58.dasnr.okstate.edu/Images/" + path)!, newsCell: self, source: self.source)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, newsCell: TableViewCell_NewsTableViewCell, source: MainViewController, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
                
                //newsCell.news_Image.frame.size = CGSize(width: newsCell.tableView.frame.width, height: ((image.size.height *  newsCell.tableView.frame.width)/image.size.width))
                
                newsCell.source.setRowToReload(index: newsCell.cellIndex, image: image)
                newsCell.tableView.reloadRows(at: [newsCell.cellIndex], with: .none)
            }
        }.resume()
    }
}

