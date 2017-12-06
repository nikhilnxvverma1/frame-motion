//
//  ControlPointView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/27/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ControlPointView: NSView {
	
	var _x : CGFloat!
	var _y : CGFloat!
	var x: CGFloat {
		get {
			return _x
		}
		set(newValue) {
			_x = newValue
			self.frame.origin.x = _x - self.frame.size.width/2
		}
	}
	
	var y: CGFloat {
		get {
			return _y
		}
		set(newValue) {
			_y = newValue
			self.frame.origin.y = _y - self.frame.size.height/2
		}
	}

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
		NSColor.orange.setFill()
		NSRectFill(dirtyRect)
		
		super.draw(dirtyRect)
    }
    
}
