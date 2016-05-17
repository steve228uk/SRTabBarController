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
    
    public var tintColor = NSColor.yellowColor()
    
    public var textColor = NSColor.whiteColor()
    
    /// The items that are displayed on the tab bar.
    /// When set, the tabs will be added to a stack view.
    public var items = [SRTabItem]() {
        didSet {
            
            stack?.removeFromSuperview()
            stack = NSStackView(views: items)
            
            addSubview(stack!)
            
            if [SRTabLocation.Top, SRTabLocation.Bottom].contains(location) {
                stack?.spacing = 45
                stack?.distribution = .EqualCentering
                
                let centerX = NSLayoutConstraint(item: stack!, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
                let centerY = NSLayoutConstraint(item: stack!, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
                
                addConstraints([centerX, centerY])
            } else {
                
                stack?.spacing = 30
                stack?.distribution = .FillEqually
                stack?.alignment = .CenterX
                
                let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[stack]-10-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["stack": stack!])
                let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[stack]", options: .DirectionLeadingToTrailing, metrics: nil, views: ["stack": stack!])
//
                addConstraints(horizontal)
                addConstraints(vertical)
            }
        
        }
    }
    
    internal var location: SRTabLocation = .Bottom
    
    /// The stack view that is added to the bar.
    /// This view contains all of the items.
    private var stack: NSStackView?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        wantsLayer = true
        layer?.backgroundColor = backgroundColor.CGColor
    }
    
    
    public func setActive(index: Int) {
        guard let views = stack?.views as? [SRTabItem] else {
            Swift.print("Could not get views from stack")
            return
        }
        
        for (current, view) in views.enumerate() {
            let tint = (index == current) ? tintColor : textColor
            view.setTintColor(tint)
        }
        
    }
}
