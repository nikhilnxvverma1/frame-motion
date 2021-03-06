//
//  SelectionOutlineView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/23/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class SelectionOutlineView: NSView {
	
	private static var boxColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)//for debugging purposes

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
		context?.setFillColor(SelectionOutlineView.boxColor)
		context?.setStrokeColor(CGColor(red: 0, green: 0, blue: 0, alpha: 1))
		context?.drawPath(using: .stroke)
		
	}

	override func mouseDown(with event: NSEvent){
		// TODO: remove if not needed
		NSLog("outline mouse down" )
	}
	
	override func mouseDragged(with event: NSEvent){
		// TODO: delegate this over to selection tool
		NSLog("outline mouse dragged" )
		
	}
	
	override func mouseUp(with event: NSEvent){
		// TODO: remove if not needed
		NSLog("outline mouse up" )
	}
	
	override func hitTest(_ point: NSPoint) -> NSView? {
		return nil
	}
	
}
