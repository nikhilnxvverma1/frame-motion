//
//  Translate.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 12/2/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class Translate: NSObject, Command {
	var shapeView : ShapeView!
	var document : Document!
	var artboardView : ArtboardView!
	var difference : NSPoint!
	
	init(shapeView : ShapeView,artboardView:ArtboardView,document : Document, difference : NSPoint) {
		super.init()
		self.document = document
		self.artboardView = artboardView
		self.shapeView = shapeView
		self.difference = difference
	}
	
	func execute(){
		shapeView!.moveBy(difference.x, difference.y)
		// TODO: also update view and model
	}
	
	func unexecute(){
		shapeView!.moveBy(-difference.x, -difference.y)
		// TODO: also update view and model
	}
	
}
