//
//  RuntimeMemoryCache.swift
//  
//
//  Created by Zuoyuan Huang on 10/23/17.
//
//

import UIKit

class RuntimeMemoryCache: NSObject {
    
    static var userDataCache = [String: UPchieveUser]()
    
    static func storeUser(withId id: String, user: UPchieveUser) {
        userDataCache[id] = user
    }
    
    static func retrieveUser(withId id: String) -> UPchieveUser? {
        return userDataCache[id]
    }

}
