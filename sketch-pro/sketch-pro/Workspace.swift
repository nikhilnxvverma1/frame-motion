//
//  Workspace.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

enum ToolType{
	case Selection
	case Artboard
	case Rectangle
	case Circle
	case Pen
	case Text
}

class Workspace: NSObject {
	private var currentToolType : ToolType = .Selection
	private var currentTool : Tool!
	var canvasHandler : CanvasHandler!
	var artboardHandler : ArtboardHandler!
	var undoStack = [Command]()
	var redoStack = [Command]()
	var document : Document!
	var windowController : WindowController!
	var selectionArea = Selection()
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
		currentTool = selectionTool
	}
	
	func setCurrent(tool : ToolType){
		
		//ignore if this doesn't make any difference
		if currentToolType==tool {
			return
		}
		
		let oldToolType = currentToolType
		currentToolType = tool
		currentTool.didGetUnselected(tool)
		
		
		//change the current Tool
		switch(tool){
		case .Artboard:
			canvasHandler = artboardTool
			artboardHandler = selectionTool
			currentTool = artboardTool
			break
		case .Selection:
			canvasHandler = selectionTool
			artboardHandler = selectionTool
			currentTool = selectionTool
			break
		case .Rectangle:
			canvasHandler = rectangleTool
			artboardHandler = rectangleTool
			currentTool = rectangleTool
			break
		case .Pen:
			// fresh layer on every change
			penTool = PenTool(self.document)
			canvasHandler = selectionTool
			artboardHandler =  penTool
			currentTool = penTool
			break
		default:
			canvasHandler = selectionTool
			artboardHandler = selectionTool
			currentTool = selectionTool
		}
		
		currentTool.didGetSelected(oldToolType)
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
