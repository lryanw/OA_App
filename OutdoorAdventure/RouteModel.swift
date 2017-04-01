//
//  RouteModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class RouteModel: NSObject {
    
    var name : String?
    var setter : String?
    var rating : String?
    var rope : String?
    var color : String?
    var overlay : String?
    
    override init() {
        
    }
    
    init(n: String, s: String, r: String, rp: String, c: String, o: String) {
        name = n
        setter = s
        rating = r
        rope = rp
        color = c
        overlay = o
    }
}
