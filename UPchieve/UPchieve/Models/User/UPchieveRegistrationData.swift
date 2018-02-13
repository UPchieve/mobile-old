//
//  UPchieveRegistrationData.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/13/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class UPchieveRegistrationData: NSObject {
    
    var registrationCode: String?
    var email: String?
    var password: String?
    
    func toJSON() -> JSON {
        let dict = ["code": registrationCode, "email": email, "password": password]
        return JSON(dict)
    }

}
