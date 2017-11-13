//
//  LoginViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/19/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import UPchieveServerAccessor

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let errorHandler: (() -> Void) = {
            self.updateUIAsync {
                self.showAlert(withTitle: "Error", message: "Login Failed")
            }
        }
        AuthService.login(withEmail: emailTextField.text!, password: passwordTextField.text!, onError: errorHandler) {
            (data) in
            let user = UserService.parseUser(withData: data)
            LocalCache.setUserAuthenticated(true)
            self.updateUIAsync {
                if user == nil {
                    self.showAlert(withTitle: "Error", message: "Could not load user profile")
                } else {
                    if user!.isVolunteer {
                        self.showAlert(withTitle: "Sorry", message: "Volunteers are not supported by current version of UPchieve. We apologize for the convenience. Please use web version instead. ")
                    } else {
                        let destination = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
                        destination.currentUser = user
                        self.navigationController?.pushViewController(destination, animated: true)
                    }
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
