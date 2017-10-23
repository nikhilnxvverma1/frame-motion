//
//  SelectionHighlightView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/22/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class SelectionHighlightView: NSView {
	
	private static var boxColor = CGColor(red: 0.3, green: 0.5, blue: 1, alpha: 0.1)
	
	var x : CGFloat {
		get{
			return self.frame.origin.x
		}
		
		set(newValue){
			self.frame.origin.x = CGFloat(newValue)
		}
	}
	
	var y : CGFloat {
		get{
			return self.frame.origin.y
		}
		
		set(newValue){
			self.frame.origin.y = CGFloat(newValue)
		}
	}
	
	var width : CGFloat {
		get{
			return self.frame.size.width
		}
		
		set(newValue){
			self.frame.size.width = CGFloat(newValue)
		}
	}
	
	var height : CGFloat {
		get{
			return self.frame.size.height
		}
		
		set(newValue){
			self.frame.size.height = CGFloat(newValue)
		}
	}

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		let context = NSGraphicsContext.current()?.cgContext
		let path = CGMutablePath()
		
		// make a rectangle from this path
		path.move(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: width, y: 0))
		path.addLine(to: CGPoint(x: width, y: height))
		path.addLine(to: CGPoint(x: 0, y: height))
		path.closeSubpath()
		
		context?.addPath(path)
//		context?.setFillColor(NSColor.blue.cgColor)
		context?.setFillColor(SelectionHighlightView.boxColor)
		context?.drawPath(using: .fillStroke)
    }
	
}
