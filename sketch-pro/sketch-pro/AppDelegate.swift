//
//  AppDelegate.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/30/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	@IBAction func undo(_ sender: Any) {
		let document = NSApplication.shared().mainWindow?.windowController?.document as! Document
		document.undo()
	}

	@IBAction func redo(_ sender: Any) {
		let document = NSApplication.shared().mainWindow?.windowController?.document as! Document
		document.redo()
	}
}

