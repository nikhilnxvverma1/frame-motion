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
		
		
		// TODO: get color and stroke from model
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
		
		var i = 0
		while i < points.count-1 {
			
			let point = points[i]
			let nextPoint = points[i+1]
			
//			let nextPointCoords = NSPoint(x: nextPoint.x, y: nextPoint.y)
			
//			if( point.forwardControlPoint != nil && nextPoint.backwardControlPoint != nil){
//				
//				let controlPoint1Coords = NSPoint(x: point.forwardControlPoint.x, y: point.forwardControlPoint.y)
//				let controlPoint2Coords = NSPoint(x: nextPoint.backwardControlPoint.x, y: nextPoint.backwardControlPoint.y)
//				
//			}else if( point.forwardControlPoint == nil && nextPoint.backwardControlPoint != nil){
//				
//				let controlPoint1Coords = NSPoint.zero
//				let controlPoint2Coords = NSPoint(x: nextPoint.backwardControlPoint.x, y: nextPoint.backwardControlPoint.y)
//				
//			}else if( point.forwardControlPoint != nil && nextPoint.backwardControlPoint == nil){
//				
//				let controlPoint1Coords = NSPoint(x: point.forwardControlPoint.x, y: point.forwardControlPoint.y)
//				let controlPoint2Coords = NSPoint.zero
//				
//			}else if( point.forwardControlPoint == nil && nextPoint.backwardControlPoint == nil){
//				
//				let controlPoint1Coords = NSPoint.zero
//				let controlPoint2Coords = NSPoint.zero
//				
//			}
			
			
			// run through this curve to search for extremas
			var t = 0.0
			while t <= 1 {
				
				// Bezier curve equation
				// (1-t)^3*P0 * 3(1-t)^2*t*P1 + 3(1-t)*t^2*P2 + t^3*P3
				let x1 = (1-t)*(1-t)*(1-t)*point.x
				let x2 = 3*(1-t)*(1-t)*t*point.forwardControlPoint.x
				let x3 = 3*(1-t)*t*t*nextPoint.backwardControlPoint.x
				let x4 = t*t*t*nextPoint.x
				let x = x1 + x2 + x3 + x4
				
				let y1 = (1-t)*(1-t)*(1-t)*point.y
				let y2 = 3*(1-t)*(1-t)*t*point.forwardControlPoint.y
				let y3 = 3*(1-t)*t*t*nextPoint.backwardControlPoint.y
				let y4 = t*t*t*nextPoint.y
				let y = y1 + y2 + y3 + y4
				
//				let y = (1-t)*(1-t)*(1-t)*point.y * 3*(1-t)*(1-t)*t*point.forwardControlPoint.y + 3*(1-t)*t*t*nextPoint.backwardControlPoint.y + t*t*t*nextPoint.y
//				let y = (1-t)^3*point.y * 3*(1-t)^2*t*point.forwardControlPoint.y + 3*(1-t)*t^2*nextPoint.backwardControlPoint.y + t^3*nextPoint.y

				if(x<CGFloat(lx)){
					lx = Double(x)
				}
				
				if(y<CGFloat(ly)){
					ly = Double(y)
				}
				
				if(x>CGFloat(hx)){
					hx = Double(x)
				}
				
				if(y>CGFloat(hy)){
					hy = Double(y)
				}
				t = t + 0.01
			}
			
			
			i+=1
		}
		
//		for point in points{
//			
//			if(point.x<CGFloat(lx)){
//				lx = Double(point.x)
//			}
//			
//			if(point.y<CGFloat(ly)){
//				ly = Double(point.y)
//			}
//			
//			if(point.x>CGFloat(hx)){
//				hx = Double(point.x)
//			}
//			
//			if(point.y>CGFloat(hy)){
//				hy = Double(point.y)
//			}
//		}
		
		self.frame.origin.x = CGFloat(lx)
		self.frame.origin.y = CGFloat(ly)
		self.frame.size.width = CGFloat(hx-lx)
		self.frame.size.height = CGFloat(hy-ly)
	}
    
}
