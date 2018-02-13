//
//  ChatMessageTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/23/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ChatMessageIncomingTableViewCell: ChatMessageTableViewCell {

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
    
    override func configure(withMessage message: UPchieveChatMessage) {
        self.userLabel.text = "Volunteer"
        self.timeLabel.text = message.time
        self.messageLabel.text = message.content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.messageLabel.sizeToFit()
    }

}
