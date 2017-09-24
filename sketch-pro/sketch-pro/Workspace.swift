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
	var windowController : WindowController!
	
	// Tools
	var artboardTool : ArtboardTool!
	var rectangleTool : RectangleTool!
	var selectionTool : SelectionTool!
	
	init(_ document : Document){
		super.init()
		self.document=document
		initializeToolset(self.document)
	}
	
	func initializeToolset(_ document : Document){
		artboardTool = ArtboardTool(self.document)
		rectangleTool = RectangleTool(self.document)
		selectionTool = SelectionTool()
		
		canvasHandler = selectionTool
	}
	
	func setCurrent(_ tool : Tool){
		
		switch(tool){
		case .Artboard:
			canvasHandler = artboardTool
			artboardHandler = SelectionTool()
		case .Selection:
			canvasHandler = selectionTool
		case .Rectangle:
			canvasHandler = rectangleTool
			artboardHandler = rectangleTool
		default:
			canvasHandler = selectionTool
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
