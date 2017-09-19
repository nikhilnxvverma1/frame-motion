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
		self.graphicView = graphicView
		self.artboardView = artboardView
		self.document = document
	}
	
	func execute(){
		self.artboardView.addSubview(graphicView)
	}
	
	func unexecute(){
		self.graphicView.removeFromSuperview()
	}
}
