//
//  SelectionTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class SelectionTool: NSObject,CanvasHandler,ArtboardHandler {
	
	private var selectionHightlight : SelectionHighlightView!
	private var document : Document!
	var originalPoint: NSPoint!
	
	init(_ document:Document) {
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
		originalPoint = localPoint
		selectionHightlight = SelectionHighlightView()
		selectionHightlight.x = localPoint.x
		selectionHightlight.y = localPoint.y
		selectionHightlight.width = 0
		selectionHightlight.height = 0
		
		artboardView.addSubview(selectionHightlight)
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		//width
		if(originalPoint.x < localPoint.x){
			selectionHightlight.width = localPoint.x - originalPoint.x
		}else{
			selectionHightlight.width =  originalPoint.x - localPoint.x
			selectionHightlight.x = localPoint.x
		}
		
		//height
		if(originalPoint.y < localPoint.y){
			selectionHightlight.height = localPoint.y - originalPoint.y
			
		}else{
			selectionHightlight.height =  originalPoint.y - localPoint.y
			selectionHightlight.y = localPoint.y
		}
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		selectionHightlight.removeFromSuperview()
		selectionHightlight = nil
	}

}
