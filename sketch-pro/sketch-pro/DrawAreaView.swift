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
    }
	
	override func mouseDown(with event: NSEvent) {
		let document = self.window?.windowController?.document as! Document
		workspace = document.workspace
		workspace.canvasHandler.mouseDown(with: event, under: self)
	}
	
	override func mouseDragged(with event: NSEvent){
		let document = self.window?.windowController?.document as! Document
		workspace = document.workspace
		workspace.canvasHandler.mouseDragged(with: event, under: self)
	}
	
	override func mouseUp(with event: NSEvent) {
		let document = self.window?.windowController?.document as! Document
		workspace = document.workspace
		workspace.canvasHandler.mouseUp(with: event, under: self)
	}
	
//	override var acceptsFirstResponder: Bool { return true }
//	
//	override func keyDown(with event: NSEvent) {
//		NSLog(" key pressed: \(event.keyCode)")
//	}
    
}
