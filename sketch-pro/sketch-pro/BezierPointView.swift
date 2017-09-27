//
//  BezierPointView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/26/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class BezierPointView: NSView {
	
	var bezierPoint : BezierPointMO!
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.frame.size.width = 10
		self.frame.size.height = 10
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		NSColor.blue.setFill()
		NSRectFill(dirtyRect)
		super.draw(dirtyRect)
    }
    
}
