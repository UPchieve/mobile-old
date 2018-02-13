//
//  Whiteboard.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 11/11/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import CoreGraphics

enum WhiteboardStatus {
    case Begin, Move, End
}

class Whiteboard: UIImageView {
    
    var userBrush: DrawingTool?
    var serverBrush: DrawingTool?
    var drawedImage: UIImage?
    
    var syncEnabled = false
    
    var currentSession: UPchieveSession?
    var currentStatus: WhiteboardStatus!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = userBrush {
            let point = touches.first!.location(in: self)
            if syncEnabled {
                SessionService.sendWhiteboardAction(startDrawingIn: currentSession!)
                SessionService.sendWhiteboardAction(saveImageIn: currentSession!)
                SessionService.sendWhiteboardAction(startAt: point, color: brush.color, toSession: currentSession!)
            }
            drawBegan(at: point, with: brush)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = userBrush {
            let point = touches.first!.location(in: self)
            if syncEnabled {
                SessionService.sendWhiteboardAction(drag: point, color: brush.color, toSession: currentSession!)
            }
            drawMoved(at: point, with: brush)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = userBrush {
            let point = touches.first!.location(in: self)
            if syncEnabled {
                SessionService.sendWhiteboardAction(endAt: point, color: brush.color, toSession: currentSession!)
                SessionService.sendWhiteboardAction(saveImageIn: currentSession!)
                SessionService.sendWhiteboardAction(endDrawingIn: currentSession!)
            }
            drawEnded(at: point, with: brush)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let brush = userBrush {
            brush.end = nil
        }
    }
    
    func listen() {
        SessionService.listenWhiteboardDragStart {
            (color, point) in
            self.updateUIAsync {
                self.drawBegan(at: point, with: self.serverBrush!)
            }
        }
        SessionService.listenWhiteboardDrag {
            (color, point) in
            self.updateUIAsync {
                self.drawMoved(at: point, with: self.serverBrush!)
            }
        }
        SessionService.listenWhiteboardDragEnd {
            (color, point) in
            self.updateUIAsync {
                self.drawEnded(at: point, with: self.serverBrush!)
            }
        }
        SessionService.listenWhiteboardColorChange {
            (color) in
            self.switchColor(color: color, brush: self.serverBrush!)
        }
        SessionService.listenWhiteboardWidthChange {
            (width) in
            self.serverBrush?.width = width
        }
        SessionService.listenWhiteboardClear {
            self.updateUIAsync {
                self.newDrawingPad()
            }
        }
    }
    
    func drawBegan(at point: CGPoint, with brush: DrawingTool) {
        brush.last = nil
        brush.start = point
        brush.end = brush.start
        currentStatus = .Begin
        drawImage(with: brush)
    }
    
    func drawMoved(at point: CGPoint, with brush: DrawingTool) {
        brush.end = point
        currentStatus = .Move
        drawImage(with: brush)
    }
    
    func drawEnded(at point: CGPoint, with brush: DrawingTool) {
        brush.end = point
        currentStatus = .End
        drawImage(with: brush)
    }
    
    func drawImage(with brush: DrawingTool?) {
        if let brush = brush {
            UIGraphicsBeginImageContext(self.bounds.size)
            let context = UIGraphicsGetCurrentContext()
            UIColor.clear.setFill()
            UIRectFill(self.bounds)
            context!.setLineCap(.round)
            context!.setLineWidth(brush.width)
            context!.setStrokeColor(brush.color.cgColor)
            if let drawedImage = drawedImage {
                drawedImage.draw(in: self.bounds)
            }
            brush.draw(inContext: context!)
            context!.strokePath()
            let preview = UIGraphicsGetImageFromCurrentImageContext()
            drawedImage = preview
            UIGraphicsEndImageContext()
            self.image = preview
            brush.last = brush.end
        }
    }

    func switchBrush(_ brush: DrawingTool) {
        userBrush = brush
        if syncEnabled {
            SessionService.sendWhiteboardAction(saveImageIn: currentSession!)
            SessionService.sendWhiteboardAction(color: brush.color, toSession: currentSession!)
            SessionService.sendWhiteboardAction(strokeWidth: brush.width, toSession: currentSession!)
        }
    }
    
    func switchColor(color: UIColor, brush: DrawingTool) {
        if brush.allowColorChange {
            if syncEnabled {
                SessionService.sendWhiteboardAction(color: color, toSession: currentSession!)
            }
            brush.color = color
        }
    }
    
    func newDrawingPad() {
        UIGraphicsBeginImageContext(self.bounds.size)
        let blank = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.drawedImage = blank
        self.image = blank
    }
    
    func clear() {
        if syncEnabled {
            SessionService.sendWhiteboardAction(clearSession: currentSession!)
        }
        newDrawingPad()
    }

}
