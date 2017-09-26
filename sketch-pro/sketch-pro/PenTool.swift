//
//  PenTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/26/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class PenTool: NSObject, CanvasHandler, ArtboardHandler {
	
	var document : Document!
	var graphicView : GraphicView!
	var bezierPoints = [BezierPointMO]()
	var latestBezierPointView : BezierPointView!
	
	init (_ document : Document){
		self.document = document
	}
	
	// MARK: Scroll View Canvas
	
	func mouseDown(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		latestBezierPointView = BezierPointView()
		latestBezierPointView.frame.origin.x = localPoint.x
		latestBezierPointView.frame.origin.y = localPoint.y
		
//		bezierPoints.append(latestBezierPointView.bezierPoint)
		artboardView.addSubview(latestBezierPointView)
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
//		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		
		
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		
//		self.document.workspace.pushCommand(command: command, executeBeforePushing: false)
	}

}
