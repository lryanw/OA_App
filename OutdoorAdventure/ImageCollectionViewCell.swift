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
    @IBOutlet weak var polaroidImage: UIImageView!
    
    override func awakeFromNib() {
        
        //Random Pin Color Generation
        var randNum = arc4random_uniform(3);
        
        if(randNum == 0) {
            polaroidImage.image = UIImage(named: "PolaroidImage_2.png");
        } else if(randNum == 1) {
            polaroidImage.image = UIImage(named: "PolaroidImage_2_Red.png");
        } else if(randNum == 2) {
            polaroidImage.image = UIImage(named: "PolaroidImage_2_Green.png");
        }
        
        //Random Rotation Generation
        randNum = arc4random_uniform(6);
        
        /*Must be done this way, CGAffineTransform(rotateAngle) does not accept a random number
        if(randNum == 0) {
            viewForImages.transform = CGAffineTransform(rotationAngle: 0.08);
        } else if(randNum == 1) {
            viewForImages.transform = CGAffineTransform(rotationAngle: -0.1);
        } else if(randNum == 2) {
            viewForImages.transform = CGAffineTransform(rotationAngle: 0.01);
        } else if(randNum == 3) {
            viewForImages.transform = CGAffineTransform(rotationAngle: -0.05);
        } else if(randNum == 4) {
            viewForImages.transform = CGAffineTransform(rotationAngle: -0.03);
        } else if(randNum == 5) {
            viewForImages.transform = CGAffineTransform(rotationAngle: 0.05);
        }
        */
    }
}
