//
//  ControlPointView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/27/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ControlPointView: NSView {
	
	var x : CGFloat!
	var y : CGFloat!

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.frame.size.width = 5
		self.frame.size.height = 5
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		// Draw a white circle 
		NSColor.red.setFill()
		NSRectFill(dirtyRect)
		super.draw(dirtyRect)
    }
    
}
