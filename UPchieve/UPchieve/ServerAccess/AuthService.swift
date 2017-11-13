//
//  AuthServices.swift
//  UPchieveServerAccessor
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class AuthService: NSObject {
    
    static func login(withEmail email: String, password: String, onError: @escaping () -> Void, onSuccess: @escaping (Data) -> Void) {
        let data = JSON(["email": email, "password": password])
        NetworkService.performLogin(withData: data) {
            (statusCode, data) in
            if statusCode == 200 {
                onSuccess(data!)
            } else {
                onError()
            }
        }
    }
    
    static func logout(onError: @escaping () -> Void, onSuccess: @escaping () -> Void) {
        NetworkService.performLogout {
            (statusCode, data) in
            if statusCode == 200 {
                LocalCache.setUserAuthenticated(false)
                onSuccess()
            } else {
                onError()
            }
        }
    }
    
    static func getUser(onError: @escaping () -> Void, onSuccess: @escaping (Data) -> Void) {
        NetworkService.getUser {
            (statusCode, data) in
            if statusCode == 200 {
                onSuccess(data!)
            } else {
                onError()
            }
        }
    }

}
