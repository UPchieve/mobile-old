//
//  LoginViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/19/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var userModel: UserModel?
    var registrationCodeVerified = false

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
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
        userModel = UserModel()
        let errorHandler: (() -> Void) = {
            self.updateUIAsync {
                self.showAlert(withTitle: "Error", message: "Login Failed")
            }
        }
        self.userModel?.login(email: emailTextField.text!, password: passwordTextField.text!, onError: errorHandler) {
            self.updateUIAsync {
                if self.userModel?.user == nil {
                    self.showAlert(withTitle: "Error", message: "Could not load user profile")
                } else {
                    if self.userModel!.user!.isVolunteer {
                        self.showAlert(withTitle: "Sorry", message: "Volunteers are not supported by current version of UPchieve. We apologize for the convenience. Please use web version instead. ")
                    } else if !(self.userModel!.user!.verified) {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "verify_email")
                        self.navigationController?.pushViewController(destination!, animated: false)
                    } else {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
                        destination.currentUser = self.userModel
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
                }
            }
        }
    }

    @IBAction func registerButtonClicked(_ sender: Any) {
        if registrationCodeVerified {
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "register_1") as! RegisterInfoViewController
            self.navigationController?.pushViewController(destination, animated: false)
        } else {
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "register_0") as! RegisterCodeViewController
            self.navigationController?.pushViewController(destination, animated: false)
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
