//
//  ControlPointView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/27/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ControlPointView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		// Draw a white circle 
		NSColor.blue.setFill()
		NSRectFill(dirtyRect)
		super.draw(dirtyRect)
    }
    
}
