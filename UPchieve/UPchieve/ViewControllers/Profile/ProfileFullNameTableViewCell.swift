//
//  ProfileFullNameTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/26/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ProfileFullNameTableViewCell: ProfileTableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if cellData?.type == .name {
            let nameCellData = cellData as! ProfileCellNameData
            if textField === firstNameTextField {
                nameCellData.firstname = firstNameTextField.text!
            } else {
                nameCellData.lastname = lastNameTextField.text!
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}
