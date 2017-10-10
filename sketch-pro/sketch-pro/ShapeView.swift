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
		
		let path = NSBezierPath()
		path.move(to:CGPoint(x: points[0].x, y: points[0].x))
		
    }
    
}
