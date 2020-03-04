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

	public var onImage : NSImage? = nil
	public var offImage : NSImage? = nil

	/// The view controller associated with this item
	public var viewController: NSViewController?

    private var tintColor: NSColor = NSColor.blue
    public var fontAttr: [NSAttributedString.Key : Any] {
        return [.font: NSFont.systemFont(ofSize: 15, weight: .semibold), .foregroundColor: tintColor]
    }
    
	// MARK: - Initializers

	init(index: Int, viewController: NSViewController) {
		super.init(frame: NSZeroRect)

		self.index = index
		self.viewController = viewController
		wantsLayer = true
		isBordered = false
		imagePosition = .imageLeft
        alignment = .left
		setButtonType(.momentaryChange)
        imageHugsTitle = true
        cell?.backgroundStyle = .normal
        
		if let title = viewController.title {
            attributedTitle = NSAttributedString(string: title, attributes: fontAttr)
		} else {
			title = ""
			imagePosition = .imageOnly
		}

		(cell as? NSButtonCell)?.highlightsBy = .changeBackgroundCellMask
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

	@objc func buttonPressed() {
		delegate?.tabIndexShouldChangeTo(index: index)
	}

	public func setTintColor(tint: NSColor) {
        self.tintColor = tint
        attributedTitle = NSAttributedString(string: title, attributes: fontAttr)

		guard let image = image else {
			Swift.print("Item has no image")
			return
		}

		image.lockFocus()
		tint.set()
		let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        __NSRectFillUsingOperation(imageRect, .sourceAtop)
		image.unlockFocus()

		self.image = image
	}


	public func buttonOn() {
		self.image = onImage
        self.layer?.backgroundColor = NSColor(calibratedRed: 0.153, green: 0.153, blue: 0.153, alpha: 0.2).cgColor
	}

	public func buttonOff() {
		self.image = offImage
        self.layer?.backgroundColor = NSColor(calibratedRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor
	}

	override open func mouseEntered(with event: NSEvent) {
		alphaValue = 0.5
	}

	override open func mouseExited(with event: NSEvent) {
		alphaValue = 1
	}


}
