//
//  NewsModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/23/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class NewsModel: NSObject {
    
    var firstName : String?
    var lastName : String?
    var profileImage : Int?
    var date : String?
    var newsText : String?
    var imagePath : String?

    override init() {
        
    }
    
    init(fN: String, lN: String, pI: Int, d: String, nT: String, iP: String) {
        firstName = fN
        lastName = lN
        profileImage = pI
        date = d
        newsText = nT
        imagePath = iP
    }
}
