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
	
	init(_ artboardView:ArtboardView,scrollView : NSScrollView,document : Document) {
		self.artboardView = artboardView
		self.scrollView = scrollView
		self.document = document
	}
	
	func execute(){
		self.scrollView.contentView.documentView?.addSubview(artboardView)
	}
	
	func unexecute(){
		self.artboardView.removeFromSuperview()
	}

}
