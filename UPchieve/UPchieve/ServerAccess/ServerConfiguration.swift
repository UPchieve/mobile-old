//
//  ServerConfiguration.swift
//  UPchieveServerAccessor
//
//  Created by Zuoyuan Huang on 10/19/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit

class ServerConfiguration: NSObject {
    
    static let SERVER_ROOT = "https://app.upchieve.org"
    static let SOCKET_ADDRESS = "142.93.89.114:3001"
    
    static let AUTH_ROOT = SERVER_ROOT + "/auth"
    static let API_ROOT = SERVER_ROOT + "/api"
    
    static let FTP_ROOT = "104.236.192.128/files"
    static let FTP_USER = "dhuang"
    static let FTP_PASSWORD = "Welcome$1"

}
