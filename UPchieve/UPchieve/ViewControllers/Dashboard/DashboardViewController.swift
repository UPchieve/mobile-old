//
//  DashboardViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var currentUser: UPchieveUser?

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        if currentUser == nil {
            loadUserDataFromServer {
                self.updateUIAsync {
                    self.welcomeLabel.text = "Welcome, " + self.currentUser!.firstname!
                }
            }
        } else {
            welcomeLabel.text = "Welcome, " + currentUser!.firstname!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getHelpButtonClicked(_ sender: Any) {
        SessionService.newSession(type: SessionType.math, user: currentUser!) {
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
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        let errorHandler: (() -> Void) = {
            self.updateUIAsync {
                self.showAlert(withTitle: "Error", message: "Cannot logout at this time")
            }
        }
        AuthService.logout(onError: errorHandler) {
            self.updateUIAsync {
                let destination = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
                self.navigationController?.pushViewController(destination, animated: true)
            }
            
        }
    }
    
    func loadUserDataFromServer(onSuccess: @escaping () -> Void) {
        NetworkService.restoreCookies()
        let errorHandler: (() -> Void) = {
            self.updateUIAsync {
                self.showAlert(withTitle: "Error", message: "Cannot load user data")
            }
        }
        AuthService.getUser(onError: errorHandler) {
            (data) in
            print("User loaded successfully")
            self.currentUser = UserService.parseUser(withData: data)
            onSuccess()
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
