//
//  ControlPointExtension.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/2/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ControlPointExtension: NSView {
	
	var anchorPoint : NSPoint!
	var controlPoint : NSPoint!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		
		// dotted line
		let aPath = NSBezierPath()
		
		aPath.move(to: CGPoint(x:anchorPoint.x, y:anchorPoint.y))
		
		aPath.line(to: CGPoint(x:controlPoint.x, y:controlPoint.y))
		
		//Keep using the method addLineToPoint until you get to the one where about to close the path
		
		aPath.close()
		
		//If you want to stroke it with a red color
		NSColor.red.set()
		aPath.stroke()
		//If you want to fill it as well
		aPath.fill()
	}
	
}
