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
    class func getImageWithColor(color: UIColor) -> UIImage {
        let size = CGSize(width: 50, height: 50);
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
}
