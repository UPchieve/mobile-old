//
//  ProfileCellData.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/26/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

enum ProfileCellType {
    case tab, name, textfield, picker, subtitledTextfield, multipleSelection
}

class ProfileCellData: NSObject {
    
    var title: String
    var type: ProfileCellType
    
    var subtitle: String?
    var pickerItems: [String]?
    
    var target: String?
    
    var currentUser: UPchieveUser?
    
    var input: String = ""
    
    init(type: ProfileCellType, title: String) {
        self.type = type
        self.title = title
        super.init()
    }
    
    convenience init(type: ProfileCellType, title: String, user: UPchieveUser, target: String) {
        self.init(type: type, title: title)
        self.currentUser = user
        self.target = target
    }
    
    convenience init(type: ProfileCellType, title: String, subtitle: String, user: UPchieveUser, target: String) {
        self.init(type: type, title: title, user: user, target: target)
        self.subtitle = subtitle
    }
    
    convenience init(type: ProfileCellType, title: String, pickerItems: [String]?, user: UPchieveUser, target: String) {
        self.init(type: type, title: title, user: user, target: target)
        self.pickerItems = pickerItems
    }
    
    func updateInputData() {
        if let target = target {
            switch target {
            case "gender":
                currentUser?.gender = input
            case "birthdate":
                currentUser?.birthdate = input
            default: break
            }
        }
    }
    
}

class ProfileCellNameData: ProfileCellData {
    
    var firstname: String {
        get {
            return currentUser?.firstname ?? ""
        }
        set(newName) {
            currentUser?.firstname = newName
        }
    }
    
    var lastname: String {
        get {
            return currentUser?.lastname ?? ""
        }
        set(newName) {
            currentUser?.lastname = newName
        }
    }
    
    init(user: UPchieveUser) {
        super.init(type: .name, title: "")
        self.currentUser = user
    }
    
}

class ProfileCellMultipleSelectionData: ProfileCellData {
    
    var selectionItems: [String]?
    var itemSelection: [Bool]?
    
    convenience init(type: ProfileCellType, title: String, selectionItems: [String]?, user: UPchieveUser, target: String) {
        self.init(type: type, title: title, user: user, target: target)
        self.selectionItems = selectionItems
        self.itemSelection = [Bool]()
        for _ in selectionItems! {
            itemSelection?.append(false)
        }
    }
    
    override func updateInputData() {
        var result = [String]()
        if let itemSelection = itemSelection {
            for i in 0..<itemSelection.count {
                if itemSelection[i] {
                    result.append(selectionItems![i])
                }
            }
        }
        if let target = target {
            switch target {
            case "groupIdentification":
                currentUser?.groupIdentification = result
            case "race":
                currentUser?.race = result
            case "computerAccess":
                currentUser?.computerAccess = result
            default: break
            }
        }
    }
    
}
