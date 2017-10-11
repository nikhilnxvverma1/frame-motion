//
//  ShapeView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/9/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa
import CoreGraphics

class ShapeView: NSView {

	var model : ShapeMO!
	var points = [BezierPointView]()
//	var outlineColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
//	var fillColor = CGColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		
		if( model == nil && points.count>0 ){
			return
		}
		
		//origin shorthands
		let ox=self.frame.origin.x
		let oy=self.frame.origin.y
		
		let path = NSBezierPath()
		
		//move to the fist point
		path.move(to:CGPoint(x: points[0].x-ox, y: points[0].y-oy))
		
		//loop throught all the bezier points
		var i = 0
		while(i<points.count-1){
			
			let point = points[i]
			let nextPoint = points[i+1]
			
			let nextPointCoords = NSPoint(x: nextPoint.x-ox, y: nextPoint.y-oy)
			
			if( point.forwardControlPoint != nil && nextPoint.backwardControlPoint != nil){
				
				let controlPoint1Coords = NSPoint(x: point.forwardControlPoint.x-ox, y: point.forwardControlPoint.y-oy)
				let controlPoint2Coords = NSPoint(x: nextPoint.backwardControlPoint.x-ox, y: nextPoint.backwardControlPoint.y-oy)
				path.curve(to: nextPointCoords, controlPoint1: controlPoint1Coords, controlPoint2: controlPoint2Coords)
				
			}else if( point.forwardControlPoint == nil && nextPoint.backwardControlPoint != nil){
				
				let controlPoint1Coords = NSPoint.zero
				let controlPoint2Coords = NSPoint(x: nextPoint.backwardControlPoint.x-ox, y: nextPoint.backwardControlPoint.y-oy)
				path.curve(to: nextPointCoords, controlPoint1: controlPoint1Coords, controlPoint2: controlPoint2Coords)
				
			}else if( point.forwardControlPoint != nil && nextPoint.backwardControlPoint == nil){
				
				let controlPoint1Coords = NSPoint(x: point.forwardControlPoint.x-ox, y: point.forwardControlPoint.y-oy)
				let controlPoint2Coords = NSPoint.zero
				path.curve(to: nextPointCoords, controlPoint1: controlPoint1Coords, controlPoint2: controlPoint2Coords)
				
			}else if( point.forwardControlPoint == nil && nextPoint.backwardControlPoint == nil){
				
				let controlPoint1Coords = NSPoint.zero
				let controlPoint2Coords = NSPoint.zero
				path.curve(to: nextPointCoords, controlPoint1: controlPoint1Coords, controlPoint2: controlPoint2Coords)
				
			}
			i+=1
		}
		
		NSColor.darkGray.setFill()
		path.stroke()
		NSColor.lightGray.setFill()
		path.fill()
		
    }
	
	func computeBounds(){
		
		var lx = 999999.0
		var ly = 999999.0
		var hx = 0.0
		var hy = 0.0
		
		for point in points{
			
			if(point.x<CGFloat(lx)){
				lx = Double(point.x)
			}
			
			if(point.y<CGFloat(ly)){
				ly = Double(point.y)
			}
			
			if(point.x>CGFloat(hx)){
				hx = Double(point.x)
			}
			
			if(point.y>CGFloat(hy)){
				hy = Double(point.y)
			}
		}
		
		self.frame.origin.x = CGFloat(lx)
		self.frame.origin.y = CGFloat(ly)
		self.frame.size.width = CGFloat(hx-lx)
		self.frame.size.height = CGFloat(hy-ly)
	}
    
}
