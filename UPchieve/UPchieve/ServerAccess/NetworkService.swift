//
//  NetworkService.swift
//  UPchieveServerAccessor
//
//  Created by Zuoyuan Huang on 10/19/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import SocketIO
import LxFTPRequest

class NetworkService: NSObject {
    
    static var socketConnected = false
    static let socket = SocketIOClient(socketURL: URL(string: ServerConfiguration.SOCKET_ADDRESS)!)
    
    static func restoreCookies() {
        if let cookies = LocalCache.retrieveCookies() {
            for cookie in cookies {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }
    
    static func establishSocketConnection() {
        if !NetworkService.socketConnected {
            NetworkService.socket.connect()
            NetworkService.socketConnected = true
        }
    }
    
    static func closeSocketConnection() {
        NetworkService.socket.disconnect()
        NetworkService.socketConnected = false
    }

    private static func sendPostRequest(toURL url: String, withData data: String?, onCompletion completion: @escaping (Int, Data?) -> Void) {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let data = data {
            request.httpBody = data.data(using: String.Encoding.utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                completion(httpResponse.statusCode, data)
            }
        }
        
        task.resume()
    }
    
    private static func sendGetRequest(toURL url: String, onCompletion completion: @escaping (Int, Data?) -> Void) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse = httpResponse {
                completion(httpResponse.statusCode, data)
            }
        }
        
        task.resume()
    }
    
    static func performLogin(withData data: JSON, onCompletion completion: @escaping (Int, Data?) -> Void) {
        sendPostRequest(toURL: ServerConfiguration.AUTH_ROOT + "/login", withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, data) in
            let url = URL(string: ServerConfiguration.AUTH_ROOT + "/login")
            let cookies = HTTPCookieStorage.shared.cookies(for: url!)
            LocalCache.storeCookies(cookies: cookies)
            completion(statusCode, data)
        }
    }
    
    static func performLogout(onCompletion completion: @escaping (Int, Data?) -> Void) {
        sendGetRequest(toURL: ServerConfiguration.AUTH_ROOT + "/logout") {
            (statusCode, data) in
            completion(statusCode, data)
        }
    }
    
    static func getUser(onCompletion completion: @escaping (Int, Data?) -> Void) {
        sendGetRequest(toURL: ServerConfiguration.API_ROOT + "/user") {
            (statusCode, data) in
            completion(statusCode, data)
        }
    }
    
    static func checkRegistrationCode(code: String, onCompletion completion: @escaping (Int, Data?) -> Void) {
        let dict = ["code": code]
        sendPostRequest(toURL: ServerConfiguration.AUTH_ROOT + "/register/check", withData: JSON(dict).rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, data) in
            completion(statusCode, data)
        }
    }
    
    static func performRegister(withData data: JSON, onCompletion completion: @escaping (Int, Data?) -> Void) {
        print(data.rawString(String.Encoding.utf8, options: [])!)
        sendPostRequest(toURL: ServerConfiguration.AUTH_ROOT + "/register", withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, data) in
            completion(statusCode, data)
        }
    }
    
    static func newSession(withData data: JSON, onCompletion completion: @escaping (Int, Data?) -> Void) {
        sendPostRequest(toURL: ServerConfiguration.API_ROOT + "/session/new", withData: data.rawString(String.Encoding.utf8, options: [])) {
            (statusCode, data) in
            completion(statusCode, data)
        }
    }
    
    static func conformVerification(withData data: JSON, onCompletion completion: @escaping (Int, Data?) -> Void) {
        print(data.rawString(String.Encoding.utf8, options: [])!)
        sendPostRequest(toURL: ServerConfiguration.API_ROOT + "/verify/confirm", withData: data.rawString(String.Encoding.utf8, options: [])!) {
            (statusCode, data) in
            completion(statusCode, data)
        }
    }
    
    static func uploadToFTP(filePath: String, filename: String, onSuccess success: @escaping () -> Void) {
        let uploadUrl = URL(string: "ftp://" + ServerConfiguration.FTP_ROOT + "/" + filename)
        let request = LxFTPRequest.upload()
        request?.serverURL = uploadUrl
        request?.localFileURL = URL(fileURLWithPath: filePath)
        request?.username = ServerConfiguration.FTP_USER
        request?.password = ServerConfiguration.FTP_PASSWORD
        request?.successAction = { (resultClass, result) in
            success()
        }
        request?.failAction = { (domain, error, errorMessage) in
        }
        request?.progressAction = {(_ totalSize: Int, _ finishedSize: Int, _ finishedPercent: CGFloat) -> Void in
        }
        request?.start()
    }

}
