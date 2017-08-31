//
//  DrawAreaBasicView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class DrawAreaBasicView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
	
	override func mouseDown(with event: NSEvent) {
		NSLog("Mouse down")
	}
	
	override func mouseDragged(with event: NSEvent){
		NSLog("Mouse Dragged")
	}
	
	override func mouseUp(with event: NSEvent) {
		NSLog("Mouse up")
	}
    
}
