//
//  RectangleTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/14/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class RectangleTool: NSObject, CanvasHandler, ArtboardHandler{
	
	var graphicView: GraphicView!
	var originalPoint: NSPoint!
	
	// MARK: Scroll View Canvas
	
	func mouseDown(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
		graphicView = GraphicView()
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		originalPoint=localPoint
		graphicView.frame.origin.x=localPoint.x
		graphicView.frame.origin.y=localPoint.y
		graphicView.frame.size.width=200
		graphicView.frame.size.height=200
		
		artboardView.addSubview(graphicView)
		NSLog("Receiving down")
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		
		NSLog("Receiving drag")
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		NSLog("Receiving up")
	}

}
