//
//  ArtboardTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ArtboardTool: NSObject,PressDragReleaseProcessor {
	func mouseDown(with event: NSEvent,under view: NSView){
		
		let subview=NSView()
		subview.wantsLayer=true
		subview.layer?.backgroundColor=NSColor.red.cgColor
		subview.frame.size.width=200
		subview.frame.size.height=200
		
		view.addSubview(subview)
		
		let localPoint = view.convert(event.locationInWindow, to: nil)
		subview.frame.origin.x=localPoint.x
		subview.frame.origin.y=localPoint.y
		NSLog("Local point on mouse down "+localPoint.debugDescription)
		NSEvent.mouseLocation()
		
		
	}
	
	func mouseDragged(with event: NSEvent,under view: NSView){
		NSLog("Mouse dragged")
	}
	
	func mouseUp(with event: NSEvent,under view: NSView){
		NSLog("Mouse up")
	}
}
