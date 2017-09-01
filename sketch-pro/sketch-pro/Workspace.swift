//
//  Workspace.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

enum Tool{
	case Selection
	case Artboard
	case Rectangle
	case Circle
}

class Workspace: NSObject {
	private var current : Tool = .Selection
	var mouseHandler : PressDragReleaseProcessor!
	
	override init(){
		mouseHandler = SelectionTool()
	}
	
	func setCurrent(_ tool : Tool){
		switch(tool){
		case .Artboard:
			mouseHandler = ArtboardTool()
		case .Selection:
			mouseHandler = SelectionTool()
		default:
			mouseHandler = SelectionTool()
		}
	}
}
