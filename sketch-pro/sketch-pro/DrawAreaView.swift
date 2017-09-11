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
		let appDelegate = NSApplication.shared().delegate as! AppDelegate
		workspace = appDelegate.workspace

    }
	
	override func mouseDown(with event: NSEvent) {
		workspace.mouseHandler.mouseDown(with: event, under: self)
	}
	
	override func mouseDragged(with event: NSEvent){
		workspace.mouseHandler.mouseDragged(with: event, under: self)
	}
	
	override func mouseUp(with event: NSEvent) {
		workspace.mouseHandler.mouseUp(with: event, under: self)
	}
    
}
