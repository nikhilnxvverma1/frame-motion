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
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
	
		
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		
		
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		
	
		
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
