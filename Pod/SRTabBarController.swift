//
//  SRTabBarController.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabBarController: NSViewController, NSTabViewDelegate, SRTabItemDelegate {
    
    /// The tab bar
    public var tabBar: SRTabBar?
    
    /// The tab view that is being used behind the scenes
    private var tabView: NSTabView?
    
    /// The background color of the tab bar
    @IBInspectable public var barBackgroundColor: NSColor = NSColor.blackColor() {
        didSet {
            tabBar?.backgroundColor = barBackgroundColor
        }
    }
    
    /// The text color of the tab bar
    @IBInspectable public var barTextColor: NSColor = NSColor.whiteColor() {
        didSet {
            tabBar?.textColor = barTextColor
        }
    }
    
    /// The tint color of the tab bar
    @IBInspectable public var barTintColor: NSColor = NSColor.yellowColor() {
        didSet {
            tabBar?.tintColor = barTintColor
        }
    }
    
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        embedTabs()
    }
    
    /**
     Load the view from the NIB
     */
    private func loadViewFromNib() {
        var nibObjects: NSArray?
        NSBundle(forClass: SRTabBarController.self).loadNibNamed("SRTabView", owner: self, topLevelObjects: &nibObjects)
        
        guard let objects = nibObjects else {
            fatalError("Could not load tab bar controller")
        }
        
        for object in objects {
            guard let view = object as? SRTabView else {
                continue
            }
            
            tabBar = view.tabBar
            tabView = view.tabView
            self.view = view
        }
        
    }
    
    
    
    // MARK: - Load Tabs
    
    /**
     Embed the tabs defined in the storyboard
     */
    private func embedTabs() {
        
        /// MAY get rejected from the MAS
        guard let segues = valueForKey("segueTemplates") as? [NSObject] else {
            print("Could not find segues")
            return
        }
        
        for segue in segues {
            if let id = segue.valueForKey("identifier") as? String {
                performSegueWithIdentifier(id, sender: self)
            }
        }
        
    }
    
    public override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        
        guard let id = segue.identifier else {
            print("Identifier not set")
            return
        }
        
        guard let vc = segue.destinationController as? NSViewController else {
            print("Could not load destination view controller")
            return
        }
        
        guard let index = Int(id.stringByReplacingOccurrencesOfString("tab_", withString: "")) else {
            print("Could not get index from identifier")
            return
        }
        
        // Add the tab item to our tab bar
        let item = SRTabItem(index: index, viewController: vc)
        item.image = NSImage(named: "Search")
        addTabItem(item)
        
    }
    
    /**
     Add a tab item to the NSTabView and the SRTabBar
     
     - parameter item: The tab item to be added
     */
    public func addTabItem(item: SRTabItem) {
    
        guard let vc = item.viewController else {
            print("View controller not set on tab item")
            return
        }
        
        let tabItem = NSTabViewItem(viewController: vc)
        tabView?.addTabViewItem(tabItem)

        item.delegate = self
        tabBar?.items.append(item)
    }
    
    
    // MARK: - NSTabViewDelegate
    
    public func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        // TODO: Hook up SRTabBarDelegate
    }
    
    // MARK; - SRTabItemDelegate
    
    func tabIndexShouldChangeTo(index: Int) {
        tabView?.selectTabViewItemAtIndex(index)
    }
    
}
