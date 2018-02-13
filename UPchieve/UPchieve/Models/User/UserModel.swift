//
//  UserModel.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/1/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    
    var user: UPchieveUser?
    
    func login(email: String, password: String, onError: @escaping () -> Void, onSuccess: @escaping () -> Void) {
        AuthService.login(withEmail: email, password: password, onError: onError) {
            (data) in
            self.user = UserService.parseUser(withData: data)
            LocalCache.setUserAuthenticated(true)
            onSuccess()
        }
    }
    
    func loadUser(onCompletion: @escaping () -> Void) {
        NetworkService.restoreCookies()
        AuthService.getUser(onError: {
            self.user = nil
            onCompletion()
        }) {
            (data) in
            self.user = UserService.parseUser(withData: data)
            onCompletion()
        }
    }

}
