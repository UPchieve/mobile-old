//
//  RegisterInfoViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/12/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegisterInfoViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
//        let destination = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
//        destination.registrationCodeVerified = true
//        self.navigationController?.pushViewController(destination, animated: false)
        
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        RegistrationService.setRegistrationInfo(email: emailTextField.text!, password: passwordTextField.text!)
        
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "registerProfile_1")
        self.navigationController?.pushViewController(destination!, animated: false)
//        RegistrationService.register(
//            onError: {
//                self.updateUIAsync {
//                    let alert = UIAlertController(title: "Error", message: "Unable to register", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alert, animated: true)
//                }
//            }
//        ) {
//            self.updateUIAsync {
//                let destination = self.storyboard?.instantiateViewController(withIdentifier: "verify_email")
//                self.navigationController?.pushViewController(destination!, animated: false)
//            }
//        }
    }

}
