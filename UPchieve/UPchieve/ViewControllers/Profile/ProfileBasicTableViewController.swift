//
//  ProfileBasicTableViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/26/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ProfileBasicTableViewController: UITableViewController {
    
    var cellData = [ProfileCellData]()
    
    var pickerViewItems = [String]()
    var associatedTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 99
        self.tableView.separatorColor = UIColor.clear
        self.tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(globalTintColor.image, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellData.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < cellData.count {
            let data = cellData[indexPath.row]
            if data.type == .name {
                let cell = tableView.dequeueReusableCell(withIdentifier: "fullNameCell", for: indexPath) as! ProfileFullNameTableViewCell
                cell.cellData = data
                return cell
            } else if data.type == .tab {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tabCell", for: indexPath) as! ProfileTagTableViewCell
                cell.cellData = data
                return cell
            } else if data.type == .textfield {
                let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! ProfileTextFieldTableViewCell
                cell.cellData = data
                return cell
            } else if data.type == .subtitledTextfield {
                let cell = tableView.dequeueReusableCell(withIdentifier: "subtitledTextFieldCell", for: indexPath) as! ProfileSubtitledTextFieldTableViewCell
                cell.cellData = data
                cell.configure()
                return cell
            } else if data.type == .picker {
                let cell = tableView.dequeueReusableCell(withIdentifier: "pickerCell", for: indexPath) as! ProfilePickerTableViewCell
                cell.cellData = data
                cell.keyboardWidth = Double(self.view.frame.width)
                cell.configure()
                return cell
            } else if data.type == .multipleSelection {
                let cell = tableView.dequeueReusableCell(withIdentifier: "multipleSelectionCell", for: indexPath) as! ProfileMultipleSelectionTableViewCell
                cell.cellData = data
                cell.configure()
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "nextButtonCell", for: indexPath)
        return cell
    }

}
