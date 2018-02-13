//
//  CompleteProfileModel.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/4/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class CompleteProfileModel: NSObject {
    
    func loadBasicProfileData(currentUser: UPchieveUser?) -> [ProfileCellData] {
        var data = [ProfileCellData]()
        data.append(ProfileCellData(type: .tab, title: ""))
        data.append(ProfileCellNameData(user: currentUser!))
        data.append(ProfileCellData(type: .subtitledTextfield, title: "Your birthday", subtitle: "MM/DD/YYYY", user: currentUser!, target: "birthdate"))
        data.append(ProfileCellData(type: .picker, title: "Your gender", pickerItems: ["Male", "Female", "Other"], user: currentUser!, target: "gender"))
        data.append(ProfileCellMultipleSelectionData(type: .multipleSelection, title: "Your Race/Ethnicity (Please select all that apply)", selectionItems: ["Hispanic or Latino", "White", "Black / African American", "American Indian / Alaskan Native", "Asian"], user: currentUser!, target: "race"))
        return data
    }
    
    func loadAcademicProfileData(currentUser: UPchieveUser?) -> [ProfileCellData] {
        var data = [ProfileCellData]()
        data.append(ProfileCellData(type: .tab, title: ""))
        data.append(ProfileCellMultipleSelectionData(type: .multipleSelection, title: "Do you identify with any of the following minority groups? (Please select all that apply)", selectionItems: ["LGBTQ", "Learning disabilities", "Other disabilities", "Immigrant", "Homeless", "Free or reduced price lunch", "Low-income", "Single-parent household", "NYCHA (public housing) resident", "None of the above"], user: currentUser!, target: "groupIdentification"))
        data.append(ProfileCellMultipleSelectionData(type: .multipleSelection, title: "Do you have access to a computer or a phone with internet access? (Please select all that apply)", selectionItems: ["I have my own computer with internet access", "My home or someone who lives with me has a computer with internet access", "I have my own smartphone with internet access", "Someone who lives with me has a smartphone with internet access", "None of the above", "Other"], user: currentUser!, target: "computerAccess"))
        return data
    }

}
