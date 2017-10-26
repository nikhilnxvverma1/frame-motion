//
//  SelectionTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class SelectionTool: NSObject,CanvasHandler,ArtboardHandler {
	
	private var selectionHightlight : SelectionHighlightView!
	private var document : Document!
	var originalPoint: NSPoint!
	
	init(_ document:Document) {
		self.document = document
	}
	
	// MARK: Scroll View Canvas
	
	func mouseDown(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		
	}
	
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		originalPoint = localPoint
		selectionHightlight = SelectionHighlightView()
		selectionHightlight.x = localPoint.x
		selectionHightlight.y = localPoint.y
		selectionHightlight.width = 0
		selectionHightlight.height = 0
		
		artboardView.addSubview(selectionHightlight)
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
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
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		selectionHightlight.removeFromSuperview()
		selectionHightlight = nil
	}
	
	private func selectOverlappingShapesIn(_ artboardView:ArtboardView,selectionBox:SelectionHighlightView){
		
		//clear the list first
		document.workspace.selectionArea?.removeAllObjects()
		
		//selection bounds
		let selectionBounds = document.workspace.selectionArea?.boundingBox
		
		if (selectionBounds?.isNull)! {
			return
		}
		
		//go through all the items in the artboard and check for overlapping bounds
		for item in document.workspace.itemList{
			
			
			//add this item to the list only if it overlaps with the selection bounds
			let selectable = item as! Selectable
			if(!selectable.boundingBox.intersection(selectionBounds!).isNull ||
				!selectionBounds!.intersection(selectable.boundingBox).isNull ||
				!selectable.boundingBox.contains(selectionBounds!) ||
				!(selectionBounds?.contains(selectable.boundingBox))!){
				
				document.workspace.selectionArea?.add(item: selectable)
			}
		}
//		let layerFetch = NSFetchRequest<LayerMO>(entityName: "Layer")
//		do{
//			layerList=try document.managedObjectContext?.fetch(layerFetch)
//			
//			for layer in layerList!{
//				let layerRect = NSRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height)
//				let selectionRect = NSRect(x: selectionBox.x, y: selectionBox.y, width: selectionBox.width, height: selectionBox.height)
//				
//				if( selectionRect.intersects(layerRect) || selectionRect.contains(layerRect)){
//					
//					// TODO: do this using views not models
////					document.workspace.currentSelection?.add(item: layer)
//				}
//			}
//			
//		}catch{
//			fatalError("Selection Error: \(error)")
//		}
	}

}
