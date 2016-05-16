//
//  SRTabBar.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabBar: NSView {

    /// Whether or not the tab bar is translucent
    public var translucent = false {
        didSet {
            // Set the translucency here
        }
    }
    
    /// The background color of the tab bar
    public var backgroundColor = NSColor.blackColor() {
        didSet {
            layer?.backgroundColor = backgroundColor.CGColor
        }
    }
    
    public var tintColor = NSColor.yellowColor() {
        didSet {
            // TODO
        }
    }
    
    public var textColor = NSColor.whiteColor() {
        didSet {
            // TODO
        }
    }
    
    /// The items that are displayed on the tab bar.
    /// When set, the tabs will be added to a stack view.
    public var items = [SRTabItem]() {
        didSet {
            stack?.removeFromSuperview()
            stack = NSStackView(views: items)
            stack?.spacing = 45
            stack?.distribution = .EqualCentering
            addSubview(stack!)
            
            let centerX = NSLayoutConstraint(item: stack!, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
            let centerY = NSLayoutConstraint(item: stack!, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
            
            addConstraints([centerX, centerY])
        }
    }
    
    
    /// The stack view that is added to the bar.
    /// This view contains all of the items.
    private var stack: NSStackView?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        wantsLayer = true
        layer?.backgroundColor = backgroundColor.CGColor
    }
    
}
