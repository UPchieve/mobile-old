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
    
    var rawData: JSON?
    
    override var description: String {
        return "UserID: \(id)\nEmail: \(email ?? "NO EMAIL")\nVolunteer: \(isVolunteer)\nFirstname: \(firstname ?? "NO NAME")"
    }
    
    init(id: String) {
        self.id = id
    }

}
