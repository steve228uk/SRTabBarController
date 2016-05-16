//
//  SRTabBarController.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabBarController: NSViewController, NSTabViewDelegate {
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        guard let v = loadViewFromNib() else {
            fatalError("SRTabBarController failed to load")
        }
        
        view = v
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        embedTabs()
    }
    
    /**
     Load the view from the NIB
     
     - returns: The view that's been loaded
     */
    private func loadViewFromNib() -> NSView? {
        var nibObjects: NSArray?
        NSBundle(forClass: SRTabBarController.self).loadNibNamed("SRTabView", owner: self, topLevelObjects: &nibObjects)
        
        guard let objects = nibObjects else {
            fatalError("Could not load tab bar controller")
        }
        
        for object in objects {
            guard let view = object as? SRTabView else {
                continue
            }
            return view
        }
        
        return nil
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
        
        guard let tabView = view as? SRTabView else {
            print("View is not a `SRTabView`")
            return
        }
        
        guard let vc = segue.destinationController as? NSViewController else {
            print("Could not load destination view controller")
            return
        }
        
        let tabItem = NSTabViewItem(viewController: vc)
        tabView.tabView.addTabViewItem(tabItem)
    }
    
    
    // MARK: - NSTabViewDelegate
    
    public func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        print(tabViewItem)
    }
    
}
