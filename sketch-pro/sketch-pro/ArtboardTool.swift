//
//  ArtboardTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ArtboardTool: NSObject,PressDragReleaseProcessor {
	var artboardView : ArtboardView!
	func mouseDown(with event: NSEvent,under view: NSScrollView){
		
		artboardView=ArtboardView()
		artboardView.wantsLayer=true
		artboardView.layer?.backgroundColor=NSColor.red.cgColor
		
		view.contentView.documentView?.addSubview(artboardView)
		
		let localPoint = view.convert(event.locationInWindow, from: nil)
		artboardView.frame.origin.x=(localPoint.x)+(view.documentVisibleRect.origin.x)
		artboardView.frame.origin.y=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-localPoint.y)
		
	}
	
	func mouseDragged(with event: NSEvent,under view: NSScrollView){
		let localPoint = view.convert(event.locationInWindow, from: nil)
		artboardView.frame.size.width=(localPoint.x)-artboardView.frame.origin.x
		// TODO calculate the right height
//		artboardView.frame.origin.y=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-localPoint.y)
		artboardView.frame.size.height=(localPoint.y)-artboardView.frame.origin.y
	}
	
	func mouseUp(with event: NSEvent,under view: NSScrollView){
		NSLog("Mouse up")
	}
}
