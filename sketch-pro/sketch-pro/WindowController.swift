//
//  WIndowController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
	
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
		
    }

	@IBAction func insertArtboard(_ sender: NSMenuItem) {
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(.Artboard)
	}
}
