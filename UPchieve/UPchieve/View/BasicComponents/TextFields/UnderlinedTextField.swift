//
//  UnderlinedTextField.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/1/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class UnderlinedTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        useUnderline()
        self.returnKeyType = .done
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        useUnderline()
        self.returnKeyType = .done
    }
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = globalTintColor.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y: self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
