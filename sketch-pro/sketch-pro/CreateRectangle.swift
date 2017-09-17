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
	
	init(_ graphicView:GraphicView,_ artboardView:ArtboardView) {
		self.graphicView = graphicView
		self.artboardView = artboardView
	}
	
	func execute(){
		self.artboardView.addSubview(graphicView)
	}
	
	func unexecute(){
		self.graphicView.removeFromSuperview()
	}
}
