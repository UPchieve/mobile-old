//
//  DashboardViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import SideMenu

class DashboardViewController: UIViewController, SidebarViewControllerSource {
    
    var currentUser: UserModel?
    var bottomViewController: DashboardBottomContainerViewController?
    var topViewController: DashboardTopContainerViewController?
    var menuLeftNavigationController: SidebarSlideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewElements()
        if currentUser == nil {
            currentUser = UserModel()
            loadUserDataFromServer()
        } else {
            self.updateUser()
        }
        // Do any additional setup after loading the view.
    }
    
    func configureViewElements() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "sideMenuNavigationController") as? SidebarSlideMenuNavigationController
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuFadeStatusBar = false
        menuLeftNavigationController?.sourceViewController = self
        let sidebarMenuButton = UIBarButtonItem(title: "Sidebar", style: .plain, target: self, action: #selector(sidebarButtonClicked))
        self.navigationItem.setLeftBarButton(sidebarMenuButton, animated: false)
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
    
    func sidebarButtonClicked() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func updateUser() {
        self.updateUIAsync {
            if let firstname = self.currentUser?.user?.firstname {
                self.topViewController?.updateWelcomeLabel("Welcome, \n" + firstname)
            } else {
                self.topViewController?.updateWelcomeLabel("Welcome, \nStudent")
            }
        }
        bottomViewController?.updateUser(self.currentUser!)
        menuLeftNavigationController?.currentUser = self.currentUser?.user
    }
    
    func loadUserDataFromServer() {
        showLoadingHUD()
        currentUser?.loadUser {
            if self.currentUser == nil {
                self.updateUIAsync {
                    self.showAlert(withTitle: "Error", message: "Cannot load user data")
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
                    AuthService.logout(onError: {
                        self.updateUIAsync {
                            self.navigationController?.pushViewController(destination, animated: true)
                        }
                    }) {
                        self.updateUIAsync {
                            self.navigationController?.pushViewController(destination, animated: true)
                        }
                    }
                }
                return
            }
            self.updateUIAsync {
                self.hideHUD()
                if self.currentUser!.user!.verified {
                    self.updateUser()
                    self.hideHUD()
                } else {
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "verify_email")
                    self.navigationController?.pushViewController(destination!, animated: true)
                }
            }
        }
    }
    
    func handleSidebarAction(action: SidebarAction) {
        if action == SidebarAction.dashboard {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashboardBottomContainerSegue" {
            bottomViewController = segue.destination as? DashboardBottomContainerViewController
        } else if segue.identifier == "dashboardTopContainerSegue" {
            topViewController = segue.destination as? DashboardTopContainerViewController
        }
    }
    
}

class DashboardTopContainerViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    func updateWelcomeLabel(_ text: String) {
        welcomeLabel.text = text
    }
    
}

class DashboardBottomContainerViewController: UIViewController {
    
    var getHelpViewController: DashboardGetHelpContainerViewController?
    
    func updateUser(_ user: UserModel) {
        getHelpViewController?.currentUser = user
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashboardGetHelpContainerSegue" {
            getHelpViewController = segue.destination as? DashboardGetHelpContainerViewController
        }
    }
    
}

class DashboardGetHelpContainerViewController: UIViewController {
    
    var currentUser: UserModel?
    
    @IBAction func getHelpButtonClicked(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "selectTopic") as! SelectTopicViewController
        destination.currentUser = self.currentUser
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
