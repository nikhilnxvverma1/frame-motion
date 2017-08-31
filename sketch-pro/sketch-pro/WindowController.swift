//
//  WIndowController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

	var workspace : Workspace!
	
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
		let appDelegate = NSApplication.shared().delegate as! AppDelegate
		workspace = appDelegate.workspace
    }

	@IBAction func insertArtboard(_ sender: NSMenuItem) {
		workspace.current = .Artboard
	}
}
