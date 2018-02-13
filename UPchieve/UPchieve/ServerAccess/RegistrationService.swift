//
//  RegistrationService.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/12/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegistrationService: NSObject {
    
    static var currentRegistration: UPchieveRegistrationData?
    
    static func checkRegistrationCode(code: String, onCompletion completion: @escaping (Bool) -> Void) {
        NetworkService.checkRegistrationCode(code: code) {
            (statusCode, data) in
            if JSON(data!)["valid"].bool == true {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func register(onError: @escaping () -> Void, onSuccess: @escaping () -> Void) {
        AuthService.register(data: (currentRegistration?.toJSON())!, onError: onError, onSuccess: onSuccess)
    }
    
    static func setRegistrationCode(_ code: String) {
        currentRegistration = UPchieveRegistrationData()
        currentRegistration?.registrationCode = code
    }
    
    static func setRegistrationInfo(email: String, password: String) {
        currentRegistration?.email = email
        currentRegistration?.password = password
    }

}
