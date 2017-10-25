//
//  GraphicVIew.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/5/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class GraphicView: NSView,Selectable {

	var x : Double {
		get{
			return Double(self.frame.origin.x)
		}
	}
	
	var y : Double {
		get{
			return Double(self.frame.origin.y)
		}
	}
	
	var width : Double{
		get{
			return Double(self.frame.size.width)
		}
	}
	
	var height : Double{
		get{
			return Double(self.frame.size.height)
		}
	}
	
	var boundingBox: NSRect{
		get{
			return NSRect(x: x, y: y, width: width, height: height)
		}
	}
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		NSColor.gray.setFill()
		NSRectFill(dirtyRect)
		super.draw(dirtyRect)
    }
	
	func didGetSelected(){
		
	}
	
	func didGetUnselected(){
		
	}
	
	func enteredDetailSelection(){
		
	}
	
	func exitedDetailSelection(){
		
	}
	
    
}
