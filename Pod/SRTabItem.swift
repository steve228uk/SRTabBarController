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
    
    // MARK: - Initializers
    
    init(index: Int, viewController: NSViewController) {
        super.init(frame: NSZeroRect)
        
        self.index = index
        self.viewController = viewController
        wantsLayer = true
        bordered = false
        imagePosition = .ImageAbove
        setButtonType(.MomentaryChange)
        
        if let title = viewController.title {
            attributedTitle = NSAttributedString(string: title, attributes: [
                NSFontAttributeName: NSFont.systemFontOfSize(10),
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ])
        } else {
            title = ""
            imagePosition = .ImageOnly
        }
        
        (cell as? NSButtonCell)?.highlightsBy = .NoCellMask
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
    
    func setTintColor(tint: NSColor) {
        
        attributedTitle = NSAttributedString(string: title, attributes: [
            NSFontAttributeName: NSFont.systemFontOfSize(10),
            NSForegroundColorAttributeName: tint
        ])
        
        guard let image = image else {
            Swift.print("Item has no image")
            return
        }
        
        image.lockFocus()
        tint.set()
        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        NSRectFillUsingOperation(imageRect, .SourceAtop)
        image.unlockFocus()
        
        self.image = image
        
    }
    
}
