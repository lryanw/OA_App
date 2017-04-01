//
//  ImageModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class ImageModel: NSObject {
    
    var imagePath : String?
    
    override init() {
        
    }
    
    init(iP: String) {
        imagePath = iP
    }
}
