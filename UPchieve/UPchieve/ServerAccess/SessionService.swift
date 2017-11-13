//
//  SessionService.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 10/22/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import SocketIO

class SessionService: NSObject {
    
    static var ongoingSession = false
    static var colorsToServerColors = [UIColor.red: "rgba(244,71,71,1)", UIColor.white: "white"]
    static var serverColorToColors = ["rgba(244,71,71,1)": UIColor.red, "white": UIColor.white]
    
    private static func colorsMap(color: UIColor) -> String {
        return colorsToServerColors[color]!
    }
    
    private static func colorsMap(serverColor: String) -> UIColor {
        if let color = serverColorToColors[serverColor] {
            return color
        }
        return UIColor.black
    }
    
    static func joinSession(withId sessionId: String, user: UPchieveUser) {
        let data = JSON(["sessionId": sessionId, "user": user.rawData!])
        NetworkService.socket.on("connect") {
            (_, _) in
            if !ongoingSession {
                NetworkService.socket.emit("join", data.rawString(String.Encoding.utf8, options: [])!)
                ongoingSession = true
            }
        }
        NetworkService.socket.connect()
    }
    
    static func newSession(type: SessionType, user: UPchieveUser, onSuccess: @escaping (Data) -> Void) {
        let data = JSON(["sessionType": type.rawValue])
        NetworkService.newSession(withData: data) {
            (statusCode, data) in
            let jsonData = JSON(data!)
            let sessionId = jsonData["sessionId"].string
            if let sessionId = sessionId {
                joinSession(withId: sessionId, user: user)
            }
            onSuccess(data!)
        }
    }
    
    static func listenSessionChange(handler: @escaping (UPchieveSession?) -> Void) {
        NetworkService.socket.on("session-change") {
            (data, ack) in
            let jsonData = JSON(data[0])
            handler(parseSession(withData: jsonData))
        }
    }
    
    static func endSession() {
        NetworkService.closeSocketConnection()
        ongoingSession = false
    }
    
    static func parseSession(withData data: Data) -> UPchieveSession? {
        return parseSession(withData: JSON(data))
    }
    
    static func parseSession(withData jsonData: JSON) -> UPchieveSession? {
        if jsonData["sessionId"].string != nil {
            return UPchieveSession(sessionId: jsonData["sessionId"].string!)
        } else if let sessionId = jsonData["_id"].string {
            let session = UPchieveSession(sessionId: sessionId)
            if jsonData["volunteer"] != JSON.null {
                session.volunteer = UserService.parseUser(withData: JSON(jsonData["volunteer"].rawValue))
            }
            return session
        }
        return nil
    }
    
    static func listenNewMessage(handler: @escaping (UPchieveChatMessage?) -> Void) {
        NetworkService.socket.on("messageSend") {
            (data, ack) in
            let jsonData = JSON(data[0])
            handler(parseChatMessage(withData: jsonData))
        }
    }
    
    static func sendMessage(message: UPchieveChatMessage, byUser user: UPchieveUser, toSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId, "user": user.rawData!, "message": message.content])
        NetworkService.socket.emit("message", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    private static func parseChatMessage(withData jsonData: JSON) -> UPchieveChatMessage? {
        let content = jsonData["contents"].string
        let firstname = jsonData["name"].string
        let time = jsonData["time"].string
        if let content = content {
            return UPchieveChatMessage(fromUser: firstname ?? "", time: time ?? "", content: content, outgoing: false)
        }
        return nil
    }
    
    private static func listenWhiteboardChange(eventName event: String, handler: @escaping (UIColor, CGPoint) -> Void) {
        NetworkService.socket.on(event) {
            (data, ack) in
            let jsonData = JSON(data[0])
            let color = colorsMap(serverColor: jsonData["color"].string!)
            let point = CGPoint(x: jsonData["x"].double! - 300, y: jsonData["y"].double! - 100)
            handler(color, point)
        }
    }
    
    static func listenWhiteboardDragStart(handler: @escaping (UIColor, CGPoint) -> Void) {
        listenWhiteboardChange(eventName: "dstart", handler: handler)
    }
    
    static func listenWhiteboardDrag(handler: @escaping (UIColor, CGPoint) -> Void) {
        listenWhiteboardChange(eventName: "drag", handler: handler)
    }
    
    static func listenWhiteboardDragEnd(handler: @escaping (UIColor, CGPoint) -> Void) {
        listenWhiteboardChange(eventName: "dend", handler: handler)
    }
    
    static func listenWhiteboardColorChange(handler: @escaping (UIColor) -> Void) {
        NetworkService.socket.on("color") {
            (data, ack) in
            let jsonData = JSON(data[0])
            let color = colorsMap(serverColor: jsonData.string!)
            handler(color)
        }
    }
    
    static func listenWhiteboardWidthChange(handler: @escaping (CGFloat) -> Void) {
        NetworkService.socket.on("width") {
            (data, ack) in
            let jsonData = JSON(data[0])
            handler(CGFloat(jsonData.double!))
        }
    }
    
    static func listenWhiteboardClear(handler: @escaping () -> Void) {
        NetworkService.socket.on("clear") {
            (data, ack) in
            handler()
        }
    }
    
    static func sendWhiteboardAction(startDrawingIn session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId])
        NetworkService.socket.emit("drawing", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(startAt point: CGPoint, color: UIColor, toSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId, "x": 300 + point.x, "y": 100 + point.y, "color": colorsMap(color: color)])
        NetworkService.socket.emit("dragStart", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(drag point: CGPoint, color: UIColor, toSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId, "x": 300 + point.x, "y": 100 + point.y, "color": colorsMap(color: color)])
        NetworkService.socket.emit("dragAction", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(endAt point: CGPoint, color: UIColor, toSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId, "x": 300 + point.x, "y": 100 + point.y, "color": colorsMap(color: color)])
        NetworkService.socket.emit("dragEnd", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(color: UIColor, toSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId, "color": colorsMap(color: color)])
        NetworkService.socket.emit("changeColor", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(strokeWidth: CGFloat, toSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId, "width": strokeWidth])
        NetworkService.socket.emit("changeWidth", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(saveImageIn session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId])
        NetworkService.socket.emit("saveImage", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(endDrawingIn session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId])
        NetworkService.socket.emit("end", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
    static func sendWhiteboardAction(clearSession session: UPchieveSession) {
        let data = JSON(["sessionId": session.sessionId])
        NetworkService.socket.emit("clearClick", data.rawString(String.Encoding.utf8, options: [])!)
    }
    
}
