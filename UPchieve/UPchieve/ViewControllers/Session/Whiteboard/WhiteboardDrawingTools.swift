//
//  Pencil.swift
//  UPchieve
//
//  Created by Zuoyuan Huang on 11/11/17.
//  Copyright © 2017 Zuoyuan Huang. All rights reserved.
//

import UIKit
import CoreGraphics

class DrawingTool {
    
    var start: CGPoint!
    var end: CGPoint!
    var last: CGPoint?
    
    var width: CGFloat = 5
    var color: UIColor = UIColor.black
    
    var allowColorChange = true
    
    func draw(inContext context: CGContext) {
    }
    
}

class WhiteboardPencil: DrawingTool {
    
    override init() {
        super.init()
        self.color = UIColor.red
    }
    
    override func draw(inContext context: CGContext) {
        if let last = last {
            context.move(to: last)
            context.addLine(to: end)
        } else {
            context.move(to: start)
            context.addLine(to: end)
        }
    }
    
    func setColor(_ color: UIColor) {
        self.color = color
    }
    
}

class WhiteboardEraser: WhiteboardPencil {
    
    override init() {
        super.init()
        self.width = 20
        self.color = UIColor.white
        self.allowColorChange = false
    }
    
    override func draw(inContext context: CGContext) {
        context.setBlendMode(.clear)
        super.draw(inContext: context)
    }
    
}
