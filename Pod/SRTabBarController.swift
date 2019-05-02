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
    public var tabBar: SRTabBar?
    
    /// The tab view that is being used behind the scenes
    public var tabView: NSTabView?
    
    /// The currently selected tab index
    public var currentIndex = 0
    
    /// The tab index used to be obtained from the identifier which would result in fixed order.
    /// To maintain it dynamic, we have this variable.
    public var tabIndex = 0
    
    /// The delegate for the controller
    public weak var delegate: SRTabBarDelegate?
    
    /// The location of the tab bar on the screen
    public var tabBarLocation: SRTabLocation = .Bottom {
        didSet {
            loadViewFromNib()
            tabBar?.location = tabBarLocation
            embedTabs()
        }
    }
    
    /// The background color of the tab bar
	@IBInspectable public var barBackgroundColor: NSColor = NSColor.black {
        didSet {
            tabBar?.backgroundColor = barBackgroundColor
        }
    }
    
    /// The text color of the tab bar 
    @IBInspectable public var barTextColor: NSColor = NSColor.white {
        didSet {
            tabBar?.textColor = barTextColor
        }
    }
    
    /// The tint color of the tab bar
    @IBInspectable public var barTintColor: NSColor = NSColor.yellow {
        didSet {
            tabBar?.tintColor = barTintColor
        }
    }
    
    /// The spacing between items on the tab bar
    @IBInspectable public var itemSpacing: CGFloat = 25 {
        didSet {
            tabBar?.itemSpacing = itemSpacing
        }
    }
    
    
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		loadViewFromNib()
	}

	open override func viewDidLoad() {
		super.viewDidLoad()
		embedTabs()
	}

	open override func viewWillAppear() {
        super.viewWillAppear()
		for item in (self.tabBar?.items)! {
			let area = NSTrackingArea.init( rect: item.bounds,
											options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways],
											owner: item, userInfo: nil)
			item.addTrackingArea(area)
		}
	}

	/**
	Load the view from the NIB
	*/
    var nibObjects: NSArray = []
	private func loadViewFromNib() {
		Bundle(for: SRTabBarController.self).loadNibNamed(tabBarLocation.rawValue, owner: self, topLevelObjects: AutoreleasingUnsafeMutablePointer(&nibObjects))

		guard nibObjects.count != 0 else {
			fatalError("Could not load tab bar controller")
		}

		for object in nibObjects {
			guard let view = object as? SRTabView else {
				continue
			}

			tabBar = view.tabBar
			tabView = view.tabView
			self.view = view

			tabBar?.backgroundColor = barBackgroundColor
			tabBar?.tintColor = barTintColor
			tabBar?.textColor = barTextColor
			tabBar?.itemSpacing = itemSpacing
		}
	}


	/**
	Select the tab item at the specified index

	- parameter index: The index to select
	*/
	public func selectTabAtIndex(index: Int) {
		tabView?.selectTabViewItem(at: index)
	}


	// MARK: - Load Tabs
    
    /**
     The default imlementation is loading all the tabs as defined in the storyboard (order of the segues).
     Hub app overrides this method to change the order of the tabs
     */
    open func setUpTabs(_ segues: [NSObject]) {
        
        for segue in segues {
            if let id = segue.value(forKey: "identifier") as? String {
                performSegue(withIdentifier: id, sender: self)
                tabIndex += 1
            }
        }
    }

	/**
	Embed the tabs defined in the storyboard
	*/
	private func embedTabs() {

		/// MAY get rejected from the MAS
		guard let segues = value(forKey: "segueTemplates") as? [NSObject] else {
			print("Could not find segues")
			return
		}

        tabIndex = 0
        setUpTabs(segues)
		tabBar?.setActive(index: currentIndex)

	}

	override open func prepare( for segue: NSStoryboardSegue, sender: Any!) {

		guard let id = segue.identifier else {
			print("Identifier not set")
			return
		}

		guard let vc = segue.destinationController as? NSViewController else {
			print("Could not load destination view controller")
			return
		}

        let pieces: [String] = id.substring(to: id.endIndex).split(separator: "_").map(String.init)
        let item = SRTabItem(index: tabIndex, viewController: vc)
		if pieces.count > 2 {
			item.offImage = NSImage(named: pieces[2] + "_inactive" )
			item.onImage = NSImage( named: pieces[2] + "_active" )
		}
		addTabItem(item: item)

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

	public func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
		guard let item = tabViewItem else {
			return
		}

		currentIndex = tabView.indexOfTabViewItem(item)
		tabBar?.setActive(index: currentIndex)
		delegate?.tabIndexChanged(index: currentIndex)
	}


	// MARK; - SRTabItemDelegate

	func tabIndexShouldChangeTo(index: Int) {
        delegate?.tabIndexShouldChange(index: index)
		tabView?.selectTabViewItem(at: index)
	}

}
