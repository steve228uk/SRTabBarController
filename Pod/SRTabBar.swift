//
//  SRTabBar.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

open class SRTabBar: NSVisualEffectView {

    /// Whether or not the tab bar is translucent
    open var translucent = false {
        didSet {
            state = (translucent) ? .active : .inactive
            backgroundView.isHidden = translucent
        }
    }
    
    /// The background color of the tab bar
    open var backgroundColor = NSColor.black {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }
    
    /// The colour used for active items
    open var tintColor = NSColor.yellow
    
    /// The colour used for inactive items
    open var textColor = NSColor.white
    
    /// Spacing between the items
    open var itemSpacing: CGFloat = 25 {
        didSet {
            stack?.spacing = itemSpacing
        }
    }
    
    /// The items that are displayed on the tab bar.
    /// When set, the tabs will be added to a stack view.
    open var items = [SRTabItem]() {
        didSet {
            
            stack?.removeFromSuperview()
            stack = NSStackView(views: items.sorted { $0.index < $1.index })
            Swift.print(itemSpacing)
            stack?.spacing = itemSpacing
            addSubview(stack!)
            
            if [SRTabLocation.top, SRTabLocation.bottom].contains(location) {
                
                let centerX = NSLayoutConstraint(item: stack!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                let centerY = NSLayoutConstraint(item: stack!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
                
                addConstraints([centerX, centerY])
            } else {
                stack?.alignment = .centerX
                
                let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[stack]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["stack": stack!])
                let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[stack]", options: NSLayoutFormatOptions(), metrics: nil, views: ["stack": stack!])
                
                addConstraints(horizontal)
                addConstraints(vertical)
            }
        
        }
    }
    
    internal var location: SRTabLocation = .bottom
    
    /// The stack view that is added to the bar.
    /// This view contains all of the items.
    fileprivate var stack: NSStackView?
    
    fileprivate var backgroundView = SRTabBarBackground()
    
    // MARK: - Methods
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        wantsLayer = true
        
        backgroundView.frame = NSZeroRect
        backgroundView.backgroundColor = backgroundColor
        addSubview(backgroundView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": backgroundView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": backgroundView]))
        
        state = .inactive
    }

    
    /**
     Set the active item on the tab bar
     
     - parameter index: The index to add
     */
    internal func setActive(_ index: Int) {
        guard let views = stack?.views as? [SRTabItem] else {
            Swift.print("Could not get views from stack")
            return
        }
        
        for (current, view) in views.enumerated() {
            let tint = (index == current) ? tintColor : textColor
            view.setTintColor(tint)
        }
        
    }
}
