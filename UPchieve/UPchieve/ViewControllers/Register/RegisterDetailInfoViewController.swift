//
//  RegisterCodeViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/12/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegisterDetailInfoViewController: UIViewController, UITextFieldDelegate{
    
    
   

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var schoolName: UITextField!
    @IBOutlet weak var hearAboutUS:UITextField!
    @IBOutlet weak var hearAboutUsPickerView: UIPickerView!
    
    var hearAboutUsOptions = ["facebook","website","friend","other"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        configureDelegateAndView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureDelegateAndView(){
        firstName.delegate = self
        lastName.delegate = self
        schoolName.delegate = self
        hearAboutUS.delegate = self
        hearAboutUsPickerView.dataSource = self
        hearAboutUsPickerView.delegate = self
        
        hearAboutUsPickerView.isOpaque = false
        hearAboutUsPickerView.isHidden = true
        
        hearAboutUS.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for:.editingChanged)
       // hearAboutUS.addTarget(self, action: #selector(hearAboutUSClicked), for: .touchUpInside)
        
        
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(destination, animated: false)
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == hearAboutUS{
            
          self.hearAboutUsPickerView.isHidden = false
            
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == hearAboutUS{
            
            self.hearAboutUsPickerView.isHidden = false
            
        }
    }

    
    func getRegistrationCode() {
        UIApplication.shared.open(URL(string: "https://upchieve.org/students")!, options: [:], completionHandler: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    
    
    @IBAction func noRegistrationCodeClicked(_ sender: Any) {
        getRegistrationCode()
    }
    
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        let code = firstName.text!
        RegistrationService.checkRegistrationCode(code: code) {
            result in
            if result {
                RegistrationService.setRegistrationCode(code)
                self.updateUIAsync {
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "register_1") as! RegisterInfoViewController
                    self.navigationController?.pushViewController(destination, animated: false)
                }
            } else {
                self.updateUIAsync {
                    let alert = UIAlertController(title: "Sorry", message: "The registration code is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "No Registration Code?", style: .default) {
                        _ in
                        self.getRegistrationCode()
                    })
                    self.present(alert, animated: true)
                }
            }
        }
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

extension RegisterDetailInfoViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hearAboutUsOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hearAboutUsOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedText = self.hearAboutUsOptions[row]
        
        self.hearAboutUS.text = selectedText
        pickerView.isHidden = true
    }
    
    
}

