//
//  ExampleWindowController.swift
//  Example
//
//  Created by Stephen Radford on 17/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

class ExampleWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
    
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .Hidden
        window?.movableByWindowBackground = true
    }

}
