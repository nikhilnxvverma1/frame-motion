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
		let cx = controlPoint.x
		let cy = controlPoint.y
		let ax = bezierPoint.x
		let ay = bezierPoint.y
		
		let bw = bezierPoint.frame.size.width
		let bh = bezierPoint.frame.size.height
		let cw = controlPoint.frame.size.width
		let ch = controlPoint.frame.size.height
		
		// line
		let aPath = NSBezierPath()
		
		//Keep using the method lineTo until you get to the one where about to close the path
		
		// first quadrant
		if (cx>=ax && cy>=ay){
			aPath.move(to: CGPoint(x:bw/2, y:bh/2))
			aPath.line(to: CGPoint(x:cx-ax+cw/2, y:cy-ay+ch/2))
		}
		
		// second quadrant
		else if (cx<=ax && cy>=ay){
			aPath.move(to: CGPoint(x:cw/2, y:cy-ay+ch/2))
			aPath.line(to: CGPoint(x:ax-cx+bw/2, y:bh/2))
		}
		
		// third quadrant
		else if (cx<=ax && cy<=ay){
			aPath.move(to: CGPoint(x:cw/2, y:ch/2))
			aPath.line(to: CGPoint(x:ax-cx+bw/2, y:ay-cy+bh/2))
		}
		
		// fourth quadrant
		else if (cx>=ax && cy<=ay){
			aPath.move(to: CGPoint(x:bw/2, y:ay-cy+bh/2))
			aPath.line(to: CGPoint(x:cx-ax+cw/2, y:ch/2))
		}
		
		aPath.close()
		
		//If you want to stroke it with a green color
		NSColor.green.set()
		aPath.stroke()
		//If you want to fill it as well
		aPath.fill()
		
	}
	
}
