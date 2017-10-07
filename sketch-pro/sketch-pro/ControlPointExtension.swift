//
//  ControlPointExtension.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/2/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ControlPointExtension: NSView {
	
//	var anchorPoint : NSPoint!
//	var controlPoint : NSPoint!
	
	var bezierPoint : BezierPointView!
	var controlPoint : ControlPointView!

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.frame.size.width = 200
		self.frame.size.height = 200
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		
		if (bezierPoint==nil || controlPoint==nil){
			return
		}
		
		self.frame.origin.x = bezierPoint.frame.origin.x
		self.frame.origin.y = bezierPoint.frame.origin.y
		self.frame.size.width = abs(bezierPoint.frame.origin.x-controlPoint.frame.origin.x)
		self.frame.size.height = abs(bezierPoint.frame.origin.y-controlPoint.frame.origin.y)
		
		// dotted line
		let aPath = NSBezierPath()
		
		aPath.move(to: CGPoint(x:0, y:0))
		
		aPath.line(to: CGPoint(x:controlPoint.frame.origin.x-bezierPoint.frame.origin.x, y:controlPoint.frame.origin.y-bezierPoint.frame.origin.y))
		
		//Keep using the method addLineToPoint until you get to the one where about to close the path
		
		aPath.close()
		
		//If you want to stroke it with a green color
		NSColor.green.set()
		aPath.stroke()
		//If you want to fill it as well
		aPath.fill()
		
		super.draw(dirtyRect)
	}
	
}
