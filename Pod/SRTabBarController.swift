//
//  SRTabBarController.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

open class SRTabBarController: NSViewController, NSTabViewDelegate, SRTabItemDelegate {
    
    /// The tab bar
    open var tabBar: SRTabBar {
        
        return (view as! SRTabView).tabBar
    }
    
    /// The tab view that is being used behind the scenes
    open var tabView: NSTabView {
        
        return (view as! SRTabView).tabView
    }
    
    /// The currently selected tab index
    open var currentIndex = 0
    
    /// The delegate for the controller
    open weak var delegate: SRTabBarDelegate?
    
    /// The location of the tab bar on the screen
    open var tabBarLocation: SRTabLocation = .bottom {
        didSet {
            loadViewFromNib()
            tabBar.location = tabBarLocation
            embedTabs()
        }
    }
    
    /// The background color of the tab bar
    @IBInspectable open var barBackgroundColor: NSColor = .black {
        didSet {
            tabBar.backgroundColor = barBackgroundColor
        }
    }
    
    /// The text color of the tab bar 
    @IBInspectable open var barTextColor: NSColor = .white {
        didSet {
            tabBar.textColor = barTextColor
        }
    }
    
    /// The tint color of the tab bar
    @IBInspectable open var barTintColor: NSColor = .yellow {
        didSet {
            tabBar.tintColor = barTintColor
        }
    }
    
    /// The spacing between items on the tab bar
    @IBInspectable public var itemSpacing: CGFloat = 25 {
        didSet {
            tabBar.itemSpacing = itemSpacing
        }
    }
    
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        loadViewFromNib()
        
        tabBar.backgroundColor = barBackgroundColor
        tabBar.tintColor = barTintColor
        tabBar.textColor = barTextColor
        tabBar.itemSpacing = itemSpacing
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        embedTabs()
    }
    
    /**
     Load the view from the NIB
     */
    private func loadViewFromNib() {
        var nibObjects: NSArray?
        Bundle(for: SRTabBarController.self).loadNibNamed(tabBarLocation.rawValue, owner: self, topLevelObjects: &nibObjects)
        
        guard let objects = nibObjects else {
            fatalError("Could not load tab bar controller")
        }

        guard let view = objects.compactMap({ $0 as? SRTabView }).first else {
            fatalError("Could not load tab view")
        }

        self.view = view
            
        tabBar.backgroundColor = barBackgroundColor
        tabBar.tintColor = barTintColor
        tabBar.textColor = barTextColor
        tabBar.itemSpacing = itemSpacing
    }
    
    /**
     Select the tab item at the specified index
     
     - parameter index: The index to select
     */
    open func selectTab(at index: Int) {
        tabView.selectTabViewItem(at: index)
    }

    @available(*, unavailable, renamed: "selectTab(at:)")
    open func selectTabAtIndex(index: Int) { fatalError("\(#function) is no longer available.") }

    
    // MARK: - Load Tabs
    
    /**
     Embed the tabs defined in the storyboard
     */
    private func embedTabs() {
        
        /// MAY get rejected from the MAS
        guard let segues = value(forKey: "segueTemplates") as? [NSObject] else {
            print("Could not find segues")
            return
        }
        
        for segue in segues {
            if let id = segue.value(forKey: "identifier") as? String {
                performSegue(withIdentifier: id, sender: self)
            }
        }
        
        tabBar.setActive(index: currentIndex)
    }

    open override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        guard let id = segue.identifier else {
            print("Identifier not set")
            return
        }
        
        guard let vc = segue.destinationController as? NSViewController else {
            print("Could not load destination view controller")
            return
        }
        
        let pieces = id.split(separator: "_")
        
        
        
        guard let index = Int(pieces[1]) else {
            print("Could not get index from identifier")
            return
        }
        
        let item = SRTabItem(index: index, viewController: vc)
        if pieces.count > 2 {
            item.image = NSImage(named: String(pieces[2]))
        }
        add(tabItem: item)
        
    }
    
    /**
     Add a tab item to the NSTabView and the SRTabBar
     
     - parameter item: The tab item to be added
     */
    open func add(tabItem item: SRTabItem) {
        
        guard let vc = item.viewController else {
            print("View controller not set on tab item")
            return
        }
        
        let tabItem = NSTabViewItem(viewController: vc)
        tabView.addTabViewItem(tabItem)
        
        item.delegate = self
        tabBar.items.append(item)
    }
    
    @available(*, unavailable, renamed: "add(tabItem:)")
    open func addTabItem(item: SRTabItem) { fatalError("\(#function) is no longer available.") }
    
    // MARK: - NSTabViewDelegate
    
    open func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        guard let item = tabViewItem else {
            return
        }
        
        currentIndex = tabView.indexOfTabViewItem(item)
        tabBar.setActive(index: currentIndex)
        delegate?.tabIndexChanged(index: currentIndex)
    }
    
    
    // MARK; - SRTabItemDelegate
    
    func tabIndexShouldChange(to index: Int) {
        tabView.selectTabViewItem(at: index)
    }
}
