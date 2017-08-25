//
//  CGTrainingView.swift
//  motion-frame
//
//  Created by Nikhil Verma on 8/25/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class CGTrainingView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		drawLine()
    }
	
	func drawLine(){
		
		let path = NSBezierPath()
		path.move(to: CGPoint(x:10,y:10))
		path.line(to: CGPoint(x:50,y:40))
		path.stroke()
	}
	
}
