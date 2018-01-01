//
//  WIndowController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
	
	var overviewController : OverviewController!
	var drawAreaController : DrawAreaController!
	var inspectorController : InspectorController!
	
    override func windowDidLoad() {
        super.windowDidLoad()
		
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.

    }
	
	func setupViewsAndCommunication(document : Document){
		//get the three view controller from the split view controller
		let splitViewController = self.contentViewController as! NSSplitViewController
		
		// order : Overview, Drawing area , Inspector
		overviewController = splitViewController.splitViewItems[0].viewController as! OverviewController
		drawAreaController = splitViewController.splitViewItems[1].viewController as! DrawAreaController
		inspectorController = splitViewController.splitViewItems[2].viewController as! InspectorController
		
		//setup delegates for communication
		overviewController.drawAreaDelegate = drawAreaController
		drawAreaController.overviewDelegate = overviewController
		drawAreaController.inspectorDelegate = inspectorController
		inspectorController.layerDelegate = drawAreaController
		
		
		overviewController.initializeDataModel(document: document)
	}
	

	@IBAction func insertArtboard(_ sender: NSMenuItem) {
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(tool:.Artboard)
		inspectorController.showArtboardControls()
	}
	
	@IBAction func appointPenTool(_ sender: Any) {
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(tool:.Pen)
		inspectorController.showPenToolControls()
	}
	@IBAction func insertRectangle(_ sender: NSMenuItem) {
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(tool:.Rectangle)
	}
	
	@IBAction func appointTextTool(_ sender: Any) {
		NSLog("TODO need to select text tool")
	}
	
	override var acceptsFirstResponder: Bool { return true }
	
	override func keyDown(with event: NSEvent) {
		NSLog(" key pressed: \(event.keyCode)")
	}
	
	override func cancelOperation(_ sender: Any?) {
		NSLog(" Escaped ")
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(tool:.Selection)
		
	}
}
