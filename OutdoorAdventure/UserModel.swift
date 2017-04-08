//
//  UserModel.swift
//  OutdoorAdventure
//
//  Created by Ryan Lee on 3/30/17.
//  Copyright © 2017 Ryan Lee. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    var firstName : String!
    var lastName : String!
    var profileImage : Int!
    var email : String!
    var isEmployee : Bool!
    
    override init() {
        
    }
    
    init(fN: String, lN: String, pI: Int, e: String, iE: Bool) {
        firstName = fN
        lastName = lN
        profileImage = pI
        email = e
        isEmployee = iE
    }
}
