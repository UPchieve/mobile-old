//
//  SidebarViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/21/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items = [SidebarItem]()
    var currentUser: UPchieveUser?

    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        loadItems()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigationController = self.navigationController as? SidebarSlideMenuNavigationController
        self.currentUser = navigationController?.currentUser
        self.usernameLabel.text = currentUser?.firstname
    }
    
    func loadItems() {
        items.append(SidebarItem(title: "Get Help", action: getHelpButtonClicked))
        items.append(SidebarItem(title: "Logout", action: logoutButtonClicked))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sidebarItemCell", for: indexPath) as! SidebarItemTableViewCell
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        cell.titleLabel.text = items[indexPath.row].title
        cell.titleLabel.highlightedTextColor = UIColor.lightGray
        cell.selectedBackgroundView = whiteView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getHelpButtonClicked() {
        let navigationController = self.navigationController as? SidebarSlideMenuNavigationController
        navigationController?.sourceViewController?.handleSidebarAction(action: SidebarAction.dashboard)
    }
    
    func logoutButtonClicked() {
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
