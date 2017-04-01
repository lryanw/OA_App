//
//  UserClimbing.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class UserClimbingModel: NSObject {
    
    var firstName : String?
    var lastName : String?
    var profileImage : Int?
    var email : String?
    var startHour : Int?
    var startMin : Int?
    var endHour : Int?
    var endMin : Int?
    
    override init() {
        
    }
    
    init(fN: String, lN: String, pI: Int, e: String, sH: Int, sM: Int, eH: Int, eM: Int) {
        firstName = fN
        lastName = lN
        profileImage = pI
        email = e
        startHour = sH
        startMin = sM
        endHour = eH
        endMin = eM
    }
}
