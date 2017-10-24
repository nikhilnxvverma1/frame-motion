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
	case Pen
}

class Workspace: NSObject {
	private var current : Tool = .Selection
	var canvasHandler : CanvasHandler!
	var artboardHandler : ArtboardHandler!
	var undoStack = [Command]()
	var redoStack = [Command]()
	var document : Document!
	var windowController : WindowController!
	var currentSelection : Selection?
	var itemList = NSMutableArray()
	
	// Tools
	var artboardTool : ArtboardTool!
	var rectangleTool : RectangleTool!
	var selectionTool : SelectionTool!
	var penTool : PenTool!
	
	init(_ document : Document){
		super.init()
		self.document=document
		initializeToolset(self.document)
	}
	
	func initializeToolset(_ document : Document){
		artboardTool = ArtboardTool(self.document)
		rectangleTool = RectangleTool(self.document)
		selectionTool = SelectionTool(self.document)
		penTool = PenTool(self.document)
		
		artboardHandler = selectionTool
		canvasHandler = selectionTool
	}
	
	func setCurrent(tool : Tool){
		
		switch(tool){
		case .Artboard:
			canvasHandler = artboardTool
			artboardHandler = selectionTool
			break
		case .Selection:
			canvasHandler = selectionTool
			artboardHandler = selectionTool
			break
		case .Rectangle:
			canvasHandler = rectangleTool
			artboardHandler = rectangleTool
			break
		case .Pen:
			// fresh layer on every change
			penTool = PenTool(self.document)
			canvasHandler = penTool
			artboardHandler =  penTool
			break
		default:
			canvasHandler = selectionTool
			artboardHandler = selectionTool
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
