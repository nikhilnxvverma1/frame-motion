//
//  InspectorController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/21/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class InspectorController: NSViewController, InspectorDelegate {
	@IBOutlet var rootView: NSView!

	var layerDelegate : LayerDelegate!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	public func showArtboardControls(){
		NSLog("artboard controls")
	}
	
	public func showPenToolControls(){
		NSLog("pen tool controls")
	}
    
}
