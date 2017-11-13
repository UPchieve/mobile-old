//
//  ServerConfiguration.swift
//  UPchieveServerAccessor
//
//  Created by Zuoyuan Huang on 10/19/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ServerConfiguration: NSObject {
    
    static let SERVER_ROOT = "http://localhost:3000"
    static let SOCKET_ADDRESS = "http://localhost:3001"
    
    static let AUTH_ROOT = SERVER_ROOT + "/auth"
    static let API_ROOT = SERVER_ROOT + "/api"

}
