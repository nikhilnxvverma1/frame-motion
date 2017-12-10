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
	
	init(shapeView : ShapeView,artboardView:ArtboardView,document : Document,name : String) {
		super.init()
		self.document = document
		self.name = name
		self.artboardView = artboardView
		self.shapeView = shapeView
	}
	
	func execute(){
		createAndPersistShape()
		self.artboardView.addSubview(shapeView)
		self.document.workspace.itemList.add(shapeView)
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
	}
	
	func unexecute(){
		self.shapeView.removeFromSuperview()
		self.document.workspace.itemList.remove(shapeView)
		self.document.managedObjectContext?.delete(shapeView.model)
		shapeView.model = nil
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
	}
	
	private func index(of:Selectable, list:[Selectable])->Int{
		
		for (index,value) in list.enumerated(){
			if value as AnyObject? == of as! _OptionalNilComparisonType {
				return index
			}
		}
		return -1
	}
	
	func createAndPersistShape(){
		shapeView.model=NSEntityDescription.insertNewObject(forEntityName: "Shape",
		                                                       into: self.document.managedObjectContext!) as! ShapeMO
		//set properties
		shapeView.model.name = name
		shapeView.model.outlineRed = 30
		shapeView.model.outlineGreen = 30
		shapeView.model.outlineBlue = 30
		shapeView.model.fillRed = 200
		shapeView.model.fillGreen = 200
		shapeView.model.fillBlue = 200
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
		
	}
}
