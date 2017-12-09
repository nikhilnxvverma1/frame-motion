//
//  Translate.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 12/2/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class Translate: NSObject, Command {
	var selectables = NSMutableArray()
	var shapeView : ShapeView!
	var document : Document!
	var artboardView : ArtboardView!
	var difference : NSPoint!
	
	init(list: NSMutableArray,artboardView:ArtboardView,document : Document, difference : NSPoint) {
		super.init()
		self.document = document
		self.artboardView = artboardView
		self.selectables = list
		self.difference = difference
	}
	
	func execute(){
		
		//move by difference
		for item in selectables{
			let selectable = item as! Selectable
			selectable.moveBy(difference.x, difference.y)
		}
		
		// also update view and model
		artboardView.setNeedsDisplay(artboardView.frame)
	}
	
	func unexecute(){
		
		//move in reverse
		for item in selectables{
			let selectable = item as! Selectable
			selectable.moveBy(-difference.x, -difference.y)
			
		}
		// also update view and model
		artboardView.setNeedsDisplay(artboardView.frame)
	}
	
	
	//not needed
	private func copy(list:NSMutableArray)->NSMutableArray{
		let copy = NSMutableArray()
		for item in list{
			copy.add(item)
		}
		return copy
	}
	
}
