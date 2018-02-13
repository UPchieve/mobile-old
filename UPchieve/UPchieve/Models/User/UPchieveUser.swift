//
//  UPchieveUser.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class UPchieveUser: NSObject {
    
    var id: String
    var email: String?
    var isVolunteer = false
    var verified = false
    
    var firstname: String?
    var lastname: String?
    var birthdate: String?
    var gender: String?
    var race: [String]?
    var groupIdentification: [String]?
    var computerAccess: [String]?
    
    var rawData: JSON?
    
    override var description: String {
        return "UserID: \(id)\nEmail: \(email ?? "NO EMAIL")\nVolunteer: \(isVolunteer)\nFirstname: \(firstname ?? "NO NAME")\nBirthdate: \(birthdate ?? "NO BIRTHDATE")\nGender: \(gender ?? "NO GENDER")\nRace: \(race ?? ["NO RACE"])\nIdentity: \(groupIdentification ?? ["NO G IDENTITY"])\n"
    }
    
    init(id: String) {
        self.id = id
    }

}
