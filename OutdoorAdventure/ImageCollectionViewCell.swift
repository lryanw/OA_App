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
    
    var imagePath : String!
    
    override func awakeFromNib() {
        cellImage.downloadedFromLink(link: imagePath!)
    }
}
