//
//  ProfileTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/27/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var cellData: ProfileCellData?

    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = whiteView
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
    }

}
