//
//  WIndowController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
	
	private var overviewController : OverviewController!
	private var drawAreaController : DrawAreaController!
	private var inspectorController : InspectorController!
	
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
		
		
		
		//rough
		let artboardFetch = NSFetchRequest<ArtboardMO>(entityName: "Artboard")
		do{
			let list=try document.managedObjectContext?.fetch(artboardFetch)
			if (list != nil){
				for artboard in list!{
					let artboardView = ArtboardView()
					drawAreaController.drawArea.contentView.documentView?.addSubview(artboardView)
					artboardView.frame.origin.x = CGFloat (artboard.x)
					artboardView.frame.origin.y = CGFloat (artboard.y)
					artboardView.frame.size.width = CGFloat(artboard.width)
					artboardView.frame.size.height = CGFloat(artboard.height)
				}
			}
		}catch{
			fatalError("Failed to fetch artboard: \(error)")
		}
	}
	

	@IBAction func insertArtboard(_ sender: NSMenuItem) {
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(.Artboard)
	}
	
	@IBAction func insertRectangle(_ sender: NSMenuItem) {
		let workspace = (self.document as! Document).workspace
		workspace?.setCurrent(.Rectangle)
	}
}
