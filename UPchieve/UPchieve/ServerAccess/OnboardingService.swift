//
//  OnboardingService.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/26/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class OnboardingService: NSObject {
    
      func conformVerification(code: String, onError: @escaping () -> Void, onSuccess: @escaping () -> Void) {
        let data = JSON(["token": code])
        NetworkService.conformVerification(withData: data) {
            (statusCode, data) in
            if JSON(data)["err"] == nil {
                onSuccess()
            } else {
                onError()
            }
        }
    }

}
