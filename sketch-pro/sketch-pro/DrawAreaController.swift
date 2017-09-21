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
	
	@IBOutlet weak var drawAreaBasicView: NSView! ;// TOOD not needed
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//		drawArea.drawAreaBasicView = drawAreaBasicView
    }
	
	override func viewWillAppear() {
		super.viewWillAppear()
//		setupViews()
	}
	
	override func viewDidAppear() {
		super.viewDidAppear()
		setupViews()
	}
	
	func setupViews(){
		let document = self.view.window?.windowController?.document
		let artboardFetch = NSFetchRequest<ArtboardMO>(entityName: "Artboard")
		do{
			let list=try document?.managedObjectContext?.fetch(artboardFetch)
			if (list != nil){
				for artboard in list!{
					let artboardView = ArtboardView()
					drawArea.addSubview(artboardView)
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
    
}
