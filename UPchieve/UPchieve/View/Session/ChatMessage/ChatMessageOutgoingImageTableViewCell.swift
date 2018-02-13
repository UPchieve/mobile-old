//
//  ChatMessageOutgoingImageTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/25/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ChatMessageOutgoingImageTableViewCell: ChatMessageTableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        self.selectedBackgroundView = whiteView
    }
    
    override func configure(withMessage message: UPchieveChatMessage) {
        self.userLabel.text = "Me"
        self.messageImageView.image = message.image
    }

    @IBAction func imageButtonClicked(_ sender: Any) {
        
    }
    
}
