//
//  SRTabItem.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabItem: NSButton {

    /// The delegate for the item
    weak var delegate: SRTabItemDelegate?
    
    /// The index of the item on the bar
    var index = 0
    
    /// The view controller associated with this item
    var viewController: NSViewController?
    
    
    // MARK : - Initializers
    
    init(index: Int, viewController: NSViewController) {
        super.init(frame: NSMakeRect(0,0,30,30))
        
        self.index = index
        self.viewController = viewController
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        
        target = self
        action = #selector(buttonPressed)
    }
    
    // MARK: - Actions
    
    func buttonPressed() {
        delegate?.tabIndexShouldChangeTo(index)
    }
    
}
