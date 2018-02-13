//
//  BasicTextFields.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/12/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding(width: Float) {
        let spacerView = UIView(frame:CGRect(x:0, y:0, width: CGFloat(width), height: self.layer.frame.height))
        self.leftViewMode = .always
        self.leftView = spacerView
    }
    
}
