//
//  AddShapeLayer.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/9/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class AddShapeLayer: NSObject, Command {
	
	var shapeView : ShapeView!
	var document : Document!
	var name : String!
	var artboardView : ArtboardView!
	
	init(artboardView:ArtboardView,document : Document,name : String) {
		super.init()
		self.document = document
		self.name = name
		self.artboardView = artboardView
	}
	
	func execute(){
		self.artboardView.addSubview(shapeView)
		saveDataModelAndReloadGraphicTable()
	}
	
	func unexecute(){
		self.shapeView.removeFromSuperview()
		self.document.managedObjectContext?.delete(shapeView.model)
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
	}
	
	func saveDataModelAndReloadGraphicTable(){
		shapeView.model=NSEntityDescription.insertNewObject(forEntityName: "Shape",
		                                                       into: self.document.managedObjectContext!) as! ShapeMO
		//set properties
		shapeView.model.name = name
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
		
	}
}
