//
//  UPchieveSession.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

enum SessionType: String {
    
    case math = "math"
    case college = "college"
    
}

class UPchieveSession: NSObject {
    
    let sessionId: String
    
    var volunteer: UPchieveUser?
    
    init(sessionId: String) {
        self.sessionId = sessionId
    }

}
