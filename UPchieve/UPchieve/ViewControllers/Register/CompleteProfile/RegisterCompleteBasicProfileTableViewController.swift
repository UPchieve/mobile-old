//
//  RegisterCompleteProfileTableViewController.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/27/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class RegisterCompleteProfileTableViewController: ProfileBasicTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        cellData = loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() -> [ProfileCellData] {
        var data = [ProfileCellData]()
        data.append(ProfileCellData(type: .tab, title: ""))
        data.append(ProfileCellNameData(firstname: "", lastname: ""))
        data.append(ProfileCellData(type: .subtitledTextfield, title: "Your birthday", subtitle: "MM/DD/YYYY", input: ""))
        data.append(ProfileCellData(type: .picker, title: "Your gender", pickerItems: ["Male", "Female", "Other"], input: "- Select gender -"))
        data.append(ProfileCellData(type: .picker, title: "Your ethnicity", pickerItems: ["Hispanic or Latino", "White", "Black / African American", "American Indian / Alaskan Native", "Asian"], input: "- Select ethnicity -"))
        data.append(ProfileCellData(type: .picker, title: "Do you identify with any of the following minority groups?", pickerItems: ["LGBTQ", "Learning disabilities", "Other disabilities", "Immigrant", "Homeless", "Free or reduced price lunch", "Low-income", "Single-parent household", "NYCHA (public housing) resident"], input: "- Select minority groups -"))
        return data
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
