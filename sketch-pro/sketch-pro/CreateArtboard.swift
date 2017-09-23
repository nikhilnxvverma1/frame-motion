//
//  CreateArtboard.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/9/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class CreateArtboard: NSObject,Command {
	
	var artboardView : ArtboardView!
	var scrollView : NSScrollView!
	var document : Document!
	var rect:NSRect!
	var selectedPage : PageMO!
	
	init(_ artboardView:ArtboardView,scrollView : NSScrollView,document : Document, rect:NSRect, saveModel:Bool) {
		super.init()
		self.artboardView = artboardView
		self.scrollView = scrollView
		self.document = document
		self.rect = rect
		selectedPage = self.document.workspace.windowController.overviewController.selectedPage
		if(saveModel){
			saveDataModel()
		}
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
	}
	
	func execute(){
		self.scrollView.contentView.documentView?.addSubview(artboardView)
		saveDataModel()
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
	}
	
	func unexecute(){
		self.artboardView.removeFromSuperview()
		self.document.managedObjectContext?.delete(artboardView.model)
		selectedPage.removeFromArtboards(self.artboardView.model)
		self.document.workspace.windowController.overviewController.graphicTable.reloadData()
	}
	
	func saveDataModel(){
		artboardView.model=NSEntityDescription.insertNewObject(forEntityName: "Artboard",
		                                                  into: self.document.managedObjectContext!) as! ArtboardMO
		//set properties
		artboardView.model.x = Float(rect.origin.x)
		artboardView.model.y = Float(rect.origin.y)
		artboardView.model.width = Float(rect.size.width)
		artboardView.model.height = Float(rect.size.height)
		
		//add this to the current selected page
		selectedPage?.addToArtboards(artboardView.model)
	}

}
