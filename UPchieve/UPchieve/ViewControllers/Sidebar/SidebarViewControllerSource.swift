//
//  SidebarViewControllerSource.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 1/25/18.
//  Copyright © 2018 Zuoyuan Huang. All rights reserved.
//

import Foundation

enum SidebarAction {
    
    case dashboard
    
}

protocol SidebarViewControllerSource {
    
    func handleSidebarAction(action: SidebarAction)
    
}
