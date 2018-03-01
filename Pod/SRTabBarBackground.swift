//
//  SRTabBarBackground.swift
//  Example
//
//  Created by Stephen Radford on 17/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

class SRTabBarBackground: NSView {

	var backgroundColor = NSColor.black {
        didSet {
            needsDisplay = true
        }
    }
    
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)

        backgroundColor.setFill()
		__NSRectFill(dirtyRect)
    }
    
}
