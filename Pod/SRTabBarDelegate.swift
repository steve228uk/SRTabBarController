//
//  SRTabBarDelegate.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public protocol SRTabBarDelegate: NSObjectProtocol {
    
    /**
     Called when the index of the active tab has changed
     
     - parameter index: The index the tab changed to
     */
    func tabIndexChanged(_ index: Int)
    
}
