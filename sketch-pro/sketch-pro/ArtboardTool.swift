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
	var initialPoint : NSPoint!
	func mouseDown(with event: NSEvent,under view: NSScrollView){
		
		artboardView=ArtboardView()
		artboardView.wantsLayer=true
		artboardView.layer?.backgroundColor=NSColor.red.cgColor
		
		view.contentView.documentView?.addSubview(artboardView)
		
		let localPoint = view.convert(event.locationInWindow, from: nil)
		initialPoint = localPoint
		artboardView.frame.origin.x=(initialPoint.x)+(view.documentVisibleRect.origin.x)
		artboardView.frame.origin.y=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-initialPoint.y)
		
	}
	
	func mouseDragged(with event: NSEvent,under view: NSScrollView){
		let localPoint = view.convert(event.locationInWindow, from: nil)
		// width
		artboardView.frame.size.width = localPoint.x - initialPoint.x
		
		if(artboardView.frame.size.width<=0){
			artboardView.frame.size.width = initialPoint.x - localPoint.x
			artboardView.frame.origin.x = localPoint.x
		}
		
		// height
		let ly=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-localPoint.y)
		let iy=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-initialPoint.y)
		let height = ly - iy
		
		
		if(height>=0){
			artboardView.frame.size.height = height
		}else{
			artboardView.frame.origin.y = ly
			artboardView.frame.size.height = -height
		}
	}
	
	func mouseUp(with event: NSEvent,under view: NSScrollView){
		NSLog("Mouse up")
	}
}
