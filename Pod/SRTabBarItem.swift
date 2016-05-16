//
//  SRTabBarItem.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabBarItem: NSView {
    
    public var title: String? {
        didSet {
             /// Set the title on the label
        }
    }
    
    private let imageView = NSImageView()
    
}