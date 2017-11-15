//
//  SelectionTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class SelectionTool: NSObject,Tool,CanvasHandler,ArtboardHandler {
	
	// used to show the dragged area
	private var selectionHightlight : SelectionHighlightView!
	
	//used to show the selected objects bounds
	private var selectionOutline : SelectionOutlineView?
	
	private var dragMadeInLastSequence = false
	
	private var document : Document!
	var originalPoint: NSPoint!
	
	init(_ document:Document) {
		self.document = document
	}
	
	// MARK: Scroll View Canvas
	
	func mouseDown(with event: NSEvent,under drawAreaView: DrawAreaView){
		let localPoint = drawAreaView.convert(event.locationInWindow, from : nil)
		originalPoint = localPoint
		selectionHightlight = SelectionHighlightView()
		selectionHightlight.x = localPoint.x
		selectionHightlight.y = localPoint.y
		selectionHightlight.width = 0
		selectionHightlight.height = 0
		
		drawAreaView.addSubview(selectionHightlight)
		
		createOutline(drawAreaView)
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		
		let localPoint = view.convert(event.locationInWindow, from : nil)
		expandAsNeeded(localPoint)
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		
		selectionHightlight.removeFromSuperview()
		selectionHightlight = nil
	}
	
	// MARK: Artboard
	
	private func createOutline(_ view:NSView){
		selectionOutline = SelectionOutlineView()
		selectionOutline?.width = 0
		selectionOutline?.height = 0
		
		view.addSubview(selectionOutline!)
	}
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		originalPoint = localPoint
		selectionHightlight = SelectionHighlightView()
		selectionHightlight.x = localPoint.x
		selectionHightlight.y = localPoint.y
		selectionHightlight.width = 0
		selectionHightlight.height = 0
		
		artboardView.addSubview(selectionHightlight)
		
		createOutline(artboardView)
		
		//reset drag flag 
		dragMadeInLastSequence = false
	}
	
	private func expandAsNeeded(_ localPoint:NSPoint){
		//width
		if(originalPoint.x < localPoint.x){
			selectionHightlight.width = localPoint.x - originalPoint.x
		}else{
			selectionHightlight.width =  originalPoint.x - localPoint.x
			selectionHightlight.x = localPoint.x
		}
		
		//height
		if(originalPoint.y < localPoint.y){
			selectionHightlight.height = localPoint.y - originalPoint.y
			
		}else{
			selectionHightlight.height =  originalPoint.y - localPoint.y
			selectionHightlight.y = localPoint.y
		}
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		
		expandAsNeeded(localPoint)
		
		// compute the overlapping shapes that make up the selection
		selectOverlappingShapesIn(selectionBox: selectionHightlight)
		
		document.workspace.selectionArea.printAllItems()
		
		//set this flag so that the highlight does not get destroyed
		dragMadeInLastSequence = true
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		selectionHightlight.removeFromSuperview()
		selectionHightlight = nil
		
		// if no drag was made, 
		if( !dragMadeInLastSequence ){
			// TODO: check if this click was done on an empty area or not
			
			computeSizeOfOutline()
		}
	}
	
	private func selectOverlappingShapesIn(selectionBox:SelectionHighlightView){
		
		//clear the list first
		document.workspace.selectionArea.removeAllObjects()
		
		//selection bounds
//		let selectionBounds = document.workspace.selectionArea.boundingBox
		let selectionBounds = selectionBox.boundingBox
		
		if (selectionBounds.isNull) {
			return
		}
		
		//go through all the items in the artboard and check for overlapping bounds
		for item in document.workspace.itemList{
			
			
			//add this item to the list only if it overlaps with the selection bounds
			let selectable = item as! Selectable
			if(!selectable.boundingBox.intersection(selectionBounds).isNull ||
				!selectionBounds.intersection(selectable.boundingBox).isNull ||
				!selectable.boundingBox.contains(selectionBounds) ||
				!(selectionBounds.contains(selectable.boundingBox))){
				
				document.workspace.selectionArea.add(item: selectable)
			}
		}
	}
	
	private func computeSizeOfOutline(){
		let bounds = document.workspace.selectionArea.boundingBox
		selectionOutline?.x = (bounds.origin.x)
		selectionOutline?.y = (bounds.origin.y)
		selectionOutline?.width = (bounds.size.width)
		selectionOutline?.height = (bounds.size.height)
		
	}
	
	func didGetSelected(_ previousToolType:ToolType){
		
	}
	
	func didGetUnselected(_ nextToolType:ToolType){
		computeSizeOfOutline()
	}
	
	func getToolType()->ToolType{
		return ToolType.Selection
	}

}
