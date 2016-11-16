//
//  SRTabItemDelegate.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Foundation

protocol SRTabItemDelegate: NSObjectProtocol {
    
    /**
     Called when a tab item is clicked and the index should change
     
     - parameter index: The index of the item clicked
     */
    func tabIndexShouldChangeTo(_ index: Int)
    
}
