//
//  ControlPointExtension.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/2/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ControlPointExtension: NSView,CALayerDelegate {
	
	var bezierPoint : BezierPointView!
	var controlPoint : ControlPointView!

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.layer = self.makeBackingLayer()
		self.layer?.delegate = self
		self.frame.size.width = 200
		self.frame.size.height = 200
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.layer = self.makeBackingLayer()
		self.layer?.delegate = self
	}
	
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		
		if (bezierPoint==nil || controlPoint==nil){
			return
		}
		
		//shorthands
		let cx = controlPoint.frame.origin.x
		let cy = controlPoint.frame.origin.y
		let ax = bezierPoint.frame.origin.x
		let ay = bezierPoint.frame.origin.y
		
		
		// line
		let aPath = NSBezierPath()
		
		//Keep using the method lineTo until you get to the one where about to close the path
		
		// first quadrant
		if (cx>=ax && cy>=ay){
			aPath.move(to: CGPoint(x:0, y:0))
			aPath.line(to: CGPoint(x:cx-ax, y:cy-ay))
		}
		
		// second quadrant
		else if (cx<=ax && cy>=ay){
			aPath.move(to: CGPoint(x:0, y:cy-ay))
			aPath.line(to: CGPoint(x:ax-cx, y:0))
		}
		
		// third quadrant
		else if (cx<=ax && cy<=ay){
			aPath.move(to: CGPoint(x:0, y:0))
			aPath.line(to: CGPoint(x:ax-cx, y:ay-cy))
		}
		
		// fourth quadrant
		else if (cx>=ax && cy<=ay){
			aPath.move(to: CGPoint(x:0, y:ay-cy))
			aPath.line(to: CGPoint(x:cx-ax, y:0))
		}
		
		aPath.close()
		
		//If you want to stroke it with a green color
		NSColor.green.set()
		aPath.stroke()
		//If you want to fill it as well
		aPath.fill()
		
	}
	
}
