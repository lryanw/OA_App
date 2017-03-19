//
//  ImageTransformer.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 1/28/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation
import UIKit

class ImageTransformer {
    class func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size);
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        color.setFill();
        UIRectFill(rect);
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return image;
    }
    
    class func maskRoundedImage(image: UIImage, radius: Float) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(radius)
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!
    }
    
    class func roundImageView(imageView: UIImageView) ->UIImageView {
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        
        return imageView
    }
}
