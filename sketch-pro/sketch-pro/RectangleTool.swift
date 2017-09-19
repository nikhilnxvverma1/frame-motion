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
	var document: Document!
	
	init(_ document : Document) {
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
		graphicView = GraphicView()
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		originalPoint=localPoint
		graphicView.frame.origin.x=localPoint.x
		graphicView.frame.origin.y=localPoint.y
		
		
		artboardView.addSubview(graphicView)
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		//width
		if(originalPoint.x < localPoint.x){
			graphicView.frame.size.width = localPoint.x - originalPoint.x
		}else{
			graphicView.frame.size.width =  originalPoint.x - localPoint.x
			graphicView.frame.origin.x = localPoint.x
		}
		
		//height
		if(originalPoint.y < localPoint.y){
			graphicView.frame.size.height = localPoint.y - originalPoint.y
		
		}else{
			graphicView.frame.size.height =  originalPoint.y - localPoint.y
			graphicView.frame.origin.y = localPoint.y
		}
		
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		let command = CreateRectangle(graphicView,artboardView,document: self.document)
		self.document.workspace.pushCommand(command: command, executeBeforePushing: false)
	}

}
