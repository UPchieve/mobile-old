//
//  SelectTopicModel.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 2/1/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import UIKit

class SelectTopicModel: NSObject {
    
    let generalTopics = ["Math": SessionType.math, "College Counseling": SessionType.college]
    let specificTopics = [SessionType.math: ["Algebra", "Geometry", "Trigonometry", "Precalculus", "Calculus"], SessionType.college: ["General Help"]]

}
