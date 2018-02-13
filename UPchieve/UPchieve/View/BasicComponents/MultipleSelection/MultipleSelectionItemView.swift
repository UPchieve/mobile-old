//
//  MultipleSelectionItemView.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/3/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class MultipleSelectionItemView: UIView {
    
    let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    var selected = false
    var index = 0

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        let label = UILabel(frame: CGRect(origin: CGPoint(x: indicatorView.frame.width, y: 0), size: CGSize(width: self.frame.width - indicatorView.frame.width, height: self.frame.height)))
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.0)
        self.addSubview(indicatorView)
        self.addSubview(label)
    }
    
    func changeSelectionStatus() {
        if selected {
            selected = false
            indicatorView.backgroundColor = UIColor.clear
        } else {
            selected = true
            indicatorView.backgroundColor = UIColor.red
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
