//
//  DrawAreaController.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class DrawAreaController: NSViewController, DrawAreaDelegate, LayerDelegate{
	
	var overviewDelegate : OverviewDelegate!
	
	var inspectorDelegate : InspectorDelegate!

	@IBOutlet weak var drawArea: DrawAreaView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	func loadContentFrom(artboardSet:NSSet?){
		if (artboardSet != nil){
			for artboardObject in artboardSet!{
				let artboardMO = artboardObject as! ArtboardMO
				let artboardView = ArtboardView()
				drawArea.contentView.documentView?.addSubview(artboardView)
				artboardView.model = artboardMO
				artboardView.frame.origin.x = CGFloat (artboardMO.x)
				artboardView.frame.origin.y = CGFloat (artboardMO.y)
				artboardView.frame.size.width = CGFloat(artboardMO.width)
				artboardView.frame.size.height = CGFloat(artboardMO.height)
			}
		}
	}
	
}
