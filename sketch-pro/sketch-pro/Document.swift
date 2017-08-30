//
//  Document.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/30/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

	override init() {
	    super.init()
		// Add your subclass-specific initialization here.
	}

	override class func autosavesInPlace() -> Bool {
		return true
	}

	override func makeWindowControllers() {
		// Returns the Storyboard that contains your Document window.
		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
		self.addWindowController(windowController)
	}

}
