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
		NSLog("Mouse down")
		let subview=NSView()
		subview.wantsLayer=true
		subview.layer?.backgroundColor=NSColor.red.cgColor
		subview.frame.size.width=200
		subview.frame.size.height=200
		
		view.addSubview(subview)
	}
	
	func mouseDragged(with event: NSEvent,under view: NSView){
		NSLog("Mouse dragged")
	}
	
	func mouseUp(with event: NSEvent,under view: NSView){
		NSLog("Mouse up")
	}
}
