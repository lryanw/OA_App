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
    
    var imagePath : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        news_Image.downloadedFromLink(link: imagePath!)
        
        news_ProfileImage = ImageTransformer.roundImageView(imageView: news_ProfileImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
