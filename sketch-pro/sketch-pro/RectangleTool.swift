//
//  RectangleTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/14/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class RectangleTool: NSObject, CanvasHandler, ArtboardHandler{
	
	// MARK: Scroll View Canvas
	
	func mouseDown(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
		NSLog("Receiving down")
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		NSLog("Receiving drag")
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		NSLog("Receiving up")
	}

}
