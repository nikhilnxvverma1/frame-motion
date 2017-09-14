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
	var canvasHandler : CanvasHandler!
	var artboardHandler : ArtboardHandler!
	var undoStack = [Command]()
	var redoStack = [Command]()
	var document : Document!
	
	init(_ document : Document){
		self.document=document
		canvasHandler = SelectionTool()
	}
	
	func setCurrent(_ tool : Tool){
		
		switch(tool){
		case .Artboard:
			canvasHandler = ArtboardTool(self)
			artboardHandler = SelectionTool()
		case .Selection:
			canvasHandler = SelectionTool()
		case .Rectangle:
			canvasHandler = RectangleTool()
			artboardHandler = RectangleTool()
		default:
			canvasHandler = SelectionTool()
		}
	}
	
	func pushCommand(command:Command!,executeBeforePushing:Bool){
		if executeBeforePushing {
			command.execute()
		}
		undoStack.append(command)
		redoStack.removeAll()
	}
	
	func undo(){
		let popped=undoStack.popLast()
		popped?.unexecute()
		if popped != nil {
			redoStack.append(popped!)
		}
	}
	
	func redo(){
		let popped=redoStack.popLast()
		popped?.execute()
		if popped != nil {
			undoStack.append(popped!)
		}
	}
}
