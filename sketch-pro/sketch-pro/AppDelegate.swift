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

	var workspace : Workspace!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		workspace = Workspace()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	@IBAction func undo(_ sender: Any) {
		NSLog("Undo called")
	}

	@IBAction func redo(_ sender: Any) {
		NSLog("Redo Called")
	}
}

