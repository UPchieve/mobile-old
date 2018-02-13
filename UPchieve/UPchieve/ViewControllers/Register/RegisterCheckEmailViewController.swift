//
//  RegisterCheckEmailViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/26/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegisterCheckEmailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        textLabel.sizeToFit()
        codeTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        AuthService.logout(onError: {
            self.updateUIAsync {
                self.navigationController?.pushViewController(destination, animated: false)
            }
        }) {
            self.updateUIAsync {
                self.navigationController?.pushViewController(destination, animated: false)
            }
        }
    }
    
    @IBAction func completeButtonClicked(_ sender: Any) {
        confirmCode(codeTextField.text!)
    }
    
    func confirmCode(_ code: String) {
        showLoadingHUD()
        /* OnboardingService.conformVerification(code: code,
            onError: {
                self.updateUIAsync {
                    self.hideHUD()
                    self.showAlert(withTitle: "Sorry", message: "We are not able to confirm this code at this time.")
                }
            }
        ) {
            self.updateUIAsync {
                self.hideHUD()
                let destination = self.storyboard?.instantiateViewController(withIdentifier: "registerProfile_1")
                self.navigationController?.pushViewController(destination!, animated: true)
            }
        } */
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "registerProfile_1")
        self.navigationController?.pushViewController(destination!, animated: true)
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
