//
//  RegisterCodeViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/12/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegisterCodeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registrationCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        registrationCodeTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        self.navigationController?.pushViewController(destination, animated: false)
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
        let code = registrationCodeTextField.text!
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
