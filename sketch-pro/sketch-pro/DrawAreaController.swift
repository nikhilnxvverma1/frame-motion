//
//  DrawAreaController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class DrawAreaController: NSViewController {

	@IBOutlet weak var drawArea: DrawAreaView!
	
	@IBOutlet weak var drawAreaBasicView: NSView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		drawArea.drawAreaBasicView = drawAreaBasicView
    }
	
	
    
}
