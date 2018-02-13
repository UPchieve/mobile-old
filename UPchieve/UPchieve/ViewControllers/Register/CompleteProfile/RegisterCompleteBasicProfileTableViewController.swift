//
//  RegisterCompleteProfileTableViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/27/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegisterCompleteBasicProfileTableViewController: ProfileBasicTableViewController {
    
    var currentUser: UPchieveUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataModel = CompleteProfileModel()
        currentUser = UPchieveUser(id: "")
        cellData = dataModel.loadBasicProfileData(currentUser: currentUser)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        for data in cellData {
            data.updateInputData()
        }
        let destination = storyboard?.instantiateViewController(withIdentifier: "registerProfile_2") as! RegisterCompleteAcademicProfileTableViewController
        destination.currentUser = currentUser
        self.navigationController?.pushViewController(destination, animated: true)
        print(currentUser)
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
