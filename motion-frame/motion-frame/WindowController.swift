//
//  WindowController.swift
//  motion-frame
//
//  Created by Nikhil Verma on 8/29/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

	@IBAction func printPressed(_ sender: Any) {
		print("logging folder action")
	}
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
