//
//  ChatMessageTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/25/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {
    
    var sessionViewController: SessionViewController?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func configure(withMessage message: UPchieveChatMessage) {
        
    }

}
