//
//  CreateText.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 1/5/18.
//  Copyright © 2018 Nikhil Verma. All rights reserved.
//

import Foundation

class CreateText: NSObject,Command {
	
	var textView : TextView!
	var artboardView : ArtboardView!
	var document : Document!
	
	init(_ textView:TextView,_ artboardView:ArtboardView, document : Document) {
		super.init()
		self.textView = textView
		self.artboardView = artboardView
		self.document = document
	}
	
	func execute(){
		self.artboardView.addSubview(textView)
		self.document.workspace.itemList.add(textView)
	}
	
	func unexecute(){
		self.textView.removeFromSuperview()
		self.document.workspace.itemList.remove(textView)
	}
}
