//
//  SRTabSegue.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

open class SRTabSegue: NSStoryboardSegue {
    
    /**
     This is empty so OS X doesn't shout at us for not overriding anything
     */
    open override func perform() {
        print("Loading \(identifier)")
    }
    
}
