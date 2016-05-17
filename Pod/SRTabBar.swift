//
//  SRTabBar.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabBar: NSVisualEffectView {

    /// Whether or not the tab bar is translucent
    public var translucent = false {
        didSet {
            setNeedsDisplayInRect(bounds)
        }
    }
    
    /// The background color of the tab bar
    public var backgroundColor = NSColor.blackColor() {
        didSet {
            setNeedsDisplayInRect(bounds)
        }
    }
    
    /// The colour used for active items
    public var tintColor = NSColor.yellowColor()
    
    /// The colour used for inactive items
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
                
                stack?.spacing = 20
                stack?.distribution = .FillEqually
                stack?.alignment = .CenterX
                
                let horizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[stack]-10-|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["stack": stack!])
                let vertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[stack]", options: .DirectionLeadingToTrailing, metrics: nil, views: ["stack": stack!])
                
                addConstraints(horizontal)
                addConstraints(vertical)
            }
        
        }
    }
    
    internal var location: SRTabLocation = .Bottom
    
    /// The stack view that is added to the bar.
    /// This view contains all of the items.
    private var stack: NSStackView?
    
    
    // MARK: - Methods
    
    public override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        if translucent {
            NSColor.clearColor().setFill()
        } else {
            backgroundColor.setFill()
        }
        
        NSRectFill(dirtyRect)
    }
    
    /**
     Set the active item on the tab bar
     
     - parameter index: The index to add
     */
    internal func setActive(index: Int) {
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
