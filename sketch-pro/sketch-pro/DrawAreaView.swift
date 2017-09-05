//
//  DrawAreaBasicView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class DrawAreaView: NSScrollView {
	
	var workspace : Workspace!
	var drawAreaBasicView : NSView!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		let appDelegate = NSApplication.shared().delegate as! AppDelegate
		workspace = appDelegate.workspace

    }
	
	override func mouseDown(with event: NSEvent) {
//		let localPoint = self.convert(event.locationInWindow, to: drawAreaBasicView)
//		NSLog("Local ppoint outside is "+localPoint.debugDescription)
		workspace.mouseHandler.mouseDown(with: event, under: self)
		
//		let subview=NSView()
//		subview.wantsLayer=true
//		subview.layer?.backgroundColor=NSColor.red.cgColor
//		subview.frame.size.width=200
//		subview.frame.size.height=200
//		
//		self.contentView.documentView?.addSubview(subview)
//		
//		let localPoint = self.convert(event.locationInWindow, from: nil)
//		subview.frame.origin.x=(localPoint.x)+(self.documentVisibleRect.origin.x)
//		subview.frame.origin.y=(self.documentVisibleRect.origin.y)+(self.documentVisibleRect.size.height-localPoint.y)
//		NSLog("Locaiton in window mouse down "+event.locationInWindow.debugDescription)
//		NSLog("Local point on mouse down "+localPoint.debugDescription)

	}
	
	override func mouseDragged(with event: NSEvent){
		workspace.mouseHandler.mouseDragged(with: event, under: self)
	}
	
	override func mouseUp(with event: NSEvent) {
		workspace.mouseHandler.mouseUp(with: event, under: self)
	}
    
}
