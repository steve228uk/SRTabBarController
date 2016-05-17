//
//  SRTabBarBackground.swift
//  Example
//
//  Created by Stephen Radford on 17/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

class SRTabBarBackground: NSView {

    var backgroundColor = NSColor.blackColor() {
        didSet {
            needsDisplay = true
        }
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        backgroundColor.setFill()
        NSRectFill(dirtyRect)
    }
    
}
