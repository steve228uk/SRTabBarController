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
     Called before the index of the active tab will changed
     
     - parameter index: The index the tab changed to
     */
    func tabIndexShouldChange(index: Int)
    
    /**
     Called when the index of the active tab has changed
     
     - parameter index: The index the tab changed to
     */
    func tabIndexChanged(index: Int)
    
}