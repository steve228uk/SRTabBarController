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
        
        tabBarLocation = .Bottom
        tabBar?.translucent = true
        tabBar?.material = .UltraDark
//        tabBar?.material = .Titlebar
        tabBar?.blendingMode = .WithinWindow
    }

}

