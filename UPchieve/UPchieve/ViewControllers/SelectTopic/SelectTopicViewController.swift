//
//  SelectTopicViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/24/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class SelectTopicViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentUser: UserModel?
    
    var model = SelectTopicModel()
    
    var toolbar: UIToolbar?
    var generalSubjectPickerView: UIPickerView?
    var specificTopicPickerView: UIPickerView?
    
    var specificTopics = [String]()
    var selectedGeneralTopic: SessionType?

    @IBOutlet weak var generalSubjectTextField: UnderlinedTextField!
    @IBOutlet weak var specificTopicTextField: UnderlinedTextField!
    @IBOutlet weak var textFieldsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = globalBackgroundColor
        textFieldsView.backgroundColor = globalBackgroundColor
        configureToolbar()
        configurePicker()
        generalSubjectTextField.delegate = self
        specificTopicTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(globalBackgroundColor.image, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.hidesBackButton = true
    }
    
    func configureToolbar() {
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        toolbar?.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar?.setItems([flexibleSpace, doneButton], animated: false)
    }
    
    func configurePicker() {
        generalSubjectPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        generalSubjectPickerView?.delegate = self
        generalSubjectPickerView?.dataSource = self
        generalSubjectTextField.text = "General Subject"
        generalSubjectTextField.inputView = generalSubjectPickerView
        generalSubjectTextField.inputAccessoryView = toolbar
        generalSubjectTextField.tintColor = UIColor.clear
        specificTopicPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        specificTopicPickerView?.delegate = self
        specificTopicPickerView?.dataSource = self
        specificTopicTextField.text = "Help Topic"
        specificTopicTextField.inputView = specificTopicPickerView
        specificTopicTextField.inputAccessoryView = toolbar
        specificTopicTextField.tintColor = UIColor.clear
    }
    
    func loadSpecificTopics(forSessionType type: SessionType?) {
        specificTopics = model.specificTopics[type!]!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === generalSubjectPickerView {
            return model.generalTopics.count
        } else {
            return specificTopics.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let labelView = view ?? UIView()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        label.textAlignment = .center
        if pickerView === generalSubjectPickerView {
            label.text = Array(model.generalTopics.keys)[row]
        } else {
            label.text = specificTopics[row]
        }
        label.font = UIFont.systemFont(ofSize: 19)
        labelView.addSubview(label)
        return labelView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === generalSubjectPickerView {
            selectedGeneralTopic = model.generalTopics[Array(model.generalTopics.keys)[row]]
            generalSubjectTextField.text = Array(model.generalTopics.keys)[row]
            loadSpecificTopics(forSessionType: model.generalTopics[Array(model.generalTopics.keys)[row]])
            specificTopicTextField.text = "- Select Specific Topic -"
        } else {
            specificTopicTextField.text = specificTopics[row]
        }
    }
    
    func doneButtonClicked() {
        if generalSubjectTextField.isFirstResponder {
            generalSubjectTextField.resignFirstResponder()
        } else {
            specificTopicTextField.resignFirstResponder()
        }
    }
    
    @IBAction func cancelButonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField === generalSubjectTextField {
            if selectedGeneralTopic == nil {
                generalSubjectTextField.text = Array(model.generalTopics.keys)[0]
                selectedGeneralTopic = model.generalTopics[Array(model.generalTopics.keys)[0]]
                loadSpecificTopics(forSessionType: model.generalTopics[Array(model.generalTopics.keys)[0]])
            }
        } else {
            if selectedGeneralTopic == nil {
                return false
            }
            specificTopicTextField.text = specificTopics[0]
        }
        return true
    }

    @IBAction func getHelpButtonClicked(_ sender: Any) {
        if let selectedGeneralTopic = selectedGeneralTopic {
            SessionService.newSession(type: selectedGeneralTopic, user: currentUser!.user!) {
                (data) in
                let session = SessionService.parseSession(withData: data)
                self.updateUIAsync {
                    if session == nil {
                        self.showAlert(withTitle: "Error", message: "Error occurred while trying to establish new session")
                    } else {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "session") as! SessionViewController
                        destination.loadSession(session: session)
                        destination.currentUser = self.currentUser
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
                }
            }
        } else {
            self.showAlert(withTitle: "Warning", message: "You have to select a general topic to continue")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
