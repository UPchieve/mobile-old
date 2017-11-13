//
//  UserService.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class UserService: NSObject {
    
    static func parseUser(withData data: Data) -> UPchieveUser? {
        let jsonData = JSON(data)["user"]
        return parseUser(withData: jsonData)
    }
    
    static func parseUser(withData jsonData: JSON) -> UPchieveUser? {
        if jsonData["_id"] != JSON.null {
            let user = UPchieveUser(id: jsonData["_id"].string!)
            user.email = jsonData["email"].string
            user.isVolunteer = jsonData["isVolunteer"].bool!
            user.verified = jsonData["verified"].bool!
            user.firstname = jsonData["firstname"].string
            user.rawData = jsonData
            return user
        }
        return nil
    }

}
