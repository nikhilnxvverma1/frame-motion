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
	var artboardModel : ArtboardMO!
	var rect:NSRect!
	
	init(_ artboardView:ArtboardView,scrollView : NSScrollView,document : Document, rect:NSRect, saveModel:Bool) {
		super.init()
		self.artboardView = artboardView
		self.scrollView = scrollView
		self.document = document
		self.rect = rect
		
		if(saveModel){
			saveDataModel()
		}
		
	}
	
	func execute(){
		self.scrollView.contentView.documentView?.addSubview(artboardView)
		saveDataModel()
	}
	
	func unexecute(){
		self.artboardView.removeFromSuperview()
		self.document.managedObjectContext?.delete(artboardModel)
	}
	
	func saveDataModel(){
		artboardModel=NSEntityDescription.insertNewObject(forEntityName: "Artboard",
		                                                  into: self.document.managedObjectContext!) as! ArtboardMO
		//set properties
		artboardModel.x = Float(rect.origin.x)
		artboardModel.y = Float(rect.origin.y)
		artboardModel.width = Float(rect.size.width)
		artboardModel.height = Float(rect.size.height)
	}

}
