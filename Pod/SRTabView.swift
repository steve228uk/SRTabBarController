//
//  SRTabView.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabView: NSView {

    @IBOutlet weak var tabView: NSTabView!
    
    @IBOutlet weak var tabBar: SRTabBar!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
}
