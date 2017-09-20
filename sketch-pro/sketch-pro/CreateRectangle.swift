//
//  CreateRectangle.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/17/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class CreateRectangle: NSObject,Command {
	
	var graphicView : GraphicView!
	var artboardView : ArtboardView!
	var document : Document!
	
	init(_ graphicView:GraphicView,_ artboardView:ArtboardView, document : Document) {
		super.init()
		self.graphicView = graphicView
		self.artboardView = artboardView
		self.document = document
		roughFetch()
	}
	
	func execute(){
		self.artboardView.addSubview(graphicView)
	}
	
	func unexecute(){
		self.graphicView.removeFromSuperview()
	}
	
	func roughFetch(){
		//rough
		let artboardFetch = NSFetchRequest<ArtboardMO>(entityName: "Artboard")
		do{
			let list=try self.document.managedObjectContext?.fetch(artboardFetch)
			if (list?.count)! > 0 {
				NSLog("height is  \(list![0].height)")
			}else{
				NSLog("NO artboard objects found")
			}
			
		}catch{
			fatalError("Failed to fetch employees: \(error)")
		}
	}
}
