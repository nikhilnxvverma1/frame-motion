//
//  ArtboardView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/5/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ArtboardView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
	
	override func mouseDown(with event: NSEvent) {
		let document = self.window?.windowController?.document as! Document
		let workspace = document.workspace
		workspace!.artboardHandler.mouseDown(with: event, artboardView: self)
	}
	
	override func mouseDragged(with event: NSEvent){
		let document = self.window?.windowController?.document as! Document
		let workspace = document.workspace
		workspace!.artboardHandler.mouseDragged(with: event, artboardView: self)
	}
	
	override func mouseUp(with event: NSEvent) {
		let document = self.window?.windowController?.document as! Document
		let workspace = document.workspace
		workspace!.artboardHandler.mouseUp(with: event, artboardView: self)
	}
}
