//
//  ProfilePickerTableViewCell.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/26/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ProfilePickerTableViewCell: ProfileTableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickedItem = ""
    var pickerViewItems = [String]()
    var pickerView: UIPickerView?
    
    var keyboardWidth = 0.0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerTextField: UnderlinedTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: keyboardWidth, height: 40))
        toolbar.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
    
    override func configure() {
        pickerViewItems = cellData!.pickerItems!
        titleLabel.text = cellData?.title
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: keyboardWidth, height: 200))
        pickerView?.delegate = self
        pickerView?.dataSource = self
        pickerTextField.text = cellData?.input
        // TODO: check if input has value
        pickerTextField.placeholder = "Select an option"
        pickerTextField.inputView = pickerView
        pickerTextField.inputAccessoryView = createToolbar()
        pickerTextField.delegate = self
        pickerTextField.tintColor = UIColor.clear

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if pickedItem == "" {
            pickedItem = pickerViewItems[0]
            cellData?.input = pickedItem
            pickerTextField.text = pickerViewItems[0]
        }
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(keyboardWidth)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let labelView = view ?? UIView()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: keyboardWidth, height: 30))
        label.textAlignment = .center
        label.text = pickerViewItems[row]
        label.font = UIFont.systemFont(ofSize: 19)
        labelView.addSubview(label)
        return labelView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField?.text = pickerViewItems[row]
        pickedItem = pickerViewItems[row]
        cellData?.input = pickedItem
    }
    
    func doneButtonClicked() {
        if pickerTextField.isFirstResponder {
            pickerTextField.resignFirstResponder()
        }
    }

}
