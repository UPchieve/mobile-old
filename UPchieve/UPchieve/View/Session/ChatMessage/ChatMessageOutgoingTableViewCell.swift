//
//  ChatMessageOutgoingTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/21/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ChatMessageOutgoingTableViewCell: ChatMessageTableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteView = UIView()
        messageLabel.numberOfLines = 0
        whiteView.backgroundColor = UIColor.white
        self.selectedBackgroundView = whiteView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func configure(withMessage message: UPchieveChatMessage) {
        self.userLabel.text = "Me"
        self.timeLabel.text = message.time
        self.messageLabel.text = message.content
        self.messageLabel.sizeToFit()
    }
        
}
