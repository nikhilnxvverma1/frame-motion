//
//  ArtboardTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ArtboardTool: NSObject,Tool,CanvasHandler {
	
	var artboardView : ArtboardView!
	var initialPoint : NSPoint!
	var document : Document!
	var artboardSoFar = 0
	
	init(_ document : Document) {
		self.document = document
	}
	
	func mouseDown(with event: NSEvent,under view: DrawAreaView){
		
		artboardView=ArtboardView()
		artboardView.wantsLayer=true
		artboardView.layer?.backgroundColor=NSColor.white.cgColor
		
		view.contentView.documentView?.addSubview(artboardView)
		
		let localPoint = view.convert(event.locationInWindow, from: nil)
		initialPoint = localPoint
		artboardView.frame.origin.x=(initialPoint.x)+(view.documentVisibleRect.origin.x)
		artboardView.frame.origin.y=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-initialPoint.y)
		
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		let localPoint = view.convert(event.locationInWindow, from: nil)
		// width
		artboardView.frame.size.width = localPoint.x - initialPoint.x
		
		if(artboardView.frame.size.width<=0){
			artboardView.frame.size.width = initialPoint.x - localPoint.x
			artboardView.frame.origin.x = localPoint.x
		}
		
		// height
		let ly=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-localPoint.y)
		let iy=(view.documentVisibleRect.origin.y)+(view.documentVisibleRect.size.height-initialPoint.y)
		let height = ly - iy
		
		
		if(height>=0){
			artboardView.frame.size.height = height
		}else{
			artboardView.frame.origin.y = ly
			artboardView.frame.size.height = -height
		}
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		
		artboardSoFar += 1
		let artboardCommand = CreateArtboard(artboardView,
		                                     scrollView:view,
		                                     document:self.document,
		                                     rect: artboardView.frame,
		                                     name : "Artboard \(artboardSoFar)",
		                                     saveModel: true)
		self.document.workspace?.pushCommand(command: artboardCommand, executeBeforePushing: false)
	}
	
	// MARK: Tool functions
	
	func didGetSelected(_ previousToolType:ToolType){
		
	}
	
	func didGetUnselected(_ nextToolType:ToolType){
		
	}
	
	func getToolType()->ToolType{
		return ToolType.Artboard
	}
}
