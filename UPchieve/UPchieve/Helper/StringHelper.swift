//
//  UITextFieldHelper.swift
//  UPchieve
//
//  Created by Jasmeet Kaur on 03/10/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//




import Swift // or Foundation
import Foundation
extension String {
    
    func isValidEmail() -> Bool {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: self)
            }
}
