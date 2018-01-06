//
//  TextTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 12/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Foundation
import Cocoa

class TextTool: NSObject, ArtboardHandler, Tool{
	
	var document : Document!
	var textView : TextView!
	var originalPoint: NSPoint!
	
	init (_ document : Document){
		self.document = document
	}
	
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
	
		textView = TextView()
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		originalPoint=localPoint
		textView.frame.origin.x=localPoint.x
		textView.frame.origin.y=localPoint.y
		
		
		artboardView.addSubview(textView)
		
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		//width
		if(originalPoint.x < localPoint.x){
			textView.frame.size.width = localPoint.x - originalPoint.x
		}else{
			textView.frame.size.width =  originalPoint.x - localPoint.x
			textView.frame.origin.x = localPoint.x
		}
		
		//height
		if(originalPoint.y < localPoint.y){
			textView.frame.size.height = localPoint.y - originalPoint.y
			
		}else{
			textView.frame.size.height =  originalPoint.y - localPoint.y
			textView.frame.origin.y = localPoint.y
		}
		
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){

		// TODO : Create Text Command
		let command = CreateText(textView,artboardView,document: self.document)
//		let command = CreateRectangle(textView,artboardView,document: self.document)
		self.document.workspace.pushCommand(command: command, executeBeforePushing: false)
		self.document.workspace.itemList.add(textView)
		
	}
	
	// MARK: Tool functions
	
	func didGetSelected(_ previousToolType:ToolType){
		
	}
	
	func didGetUnselected(_ nextToolType:ToolType){
		
	}
	
	func getToolType()->ToolType{
		return ToolType.Text
	}
}
