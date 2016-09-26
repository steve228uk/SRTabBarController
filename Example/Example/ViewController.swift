//
//  ViewController.swift
//  Example
//
//  Created by Stephen Radford on 15/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

class ViewController: SRTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarWidth = 60
        tabBarLocation = .Top
        tabBar?.translucent = true
//        tabBar?.backgroundColor = NSColor.darkGrayColor()
//        tabBar?.material = .UltraDark
        tabBar?.material = .Titlebar
        tabBar?.blendingMode = .WithinWindow
    }

}

