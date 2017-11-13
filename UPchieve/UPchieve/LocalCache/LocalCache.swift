//
//  LocalCache.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/23/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class LocalCache: NSObject {
    
    static func storeUser(withId id: String, user: UPchieveUser) {
        RuntimeMemoryCache.storeUser(withId: id, user: user)
    }
    
    static func retrieveUser(withId id: String) -> UPchieveUser? {
        return RuntimeMemoryCache.retrieveUser(withId: id)
    }
    
    static func storeCookies(cookies: [HTTPCookie]?) {
        if let cookies = cookies {
            let data = NSKeyedArchiver.archivedData(withRootObject: cookies)
            UserDefaults.standard.set(data, forKey: "Cookies")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func retrieveCookies() -> [HTTPCookie]? {
        let cookiesData = UserDefaults.standard.object(forKey: "Cookies") as! Data
        if cookiesData.count > 0 {
            let cookies = NSKeyedUnarchiver.unarchiveObject(with: cookiesData) as! [HTTPCookie]
            return cookies
            
        }
        return nil
    }
    
    static func setUserAuthenticated(_ authenticated: Bool) {
        UserDefaults.standard.set(authenticated, forKey: "isAuthenticated")
        UserDefaults.standard.synchronize()
    }
    
    static func isUserAuthenticated() -> Bool {
        return UserDefaults.standard.bool(forKey: "isAuthenticated")
    }

}
