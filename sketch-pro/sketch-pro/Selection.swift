//
//  MultipleSelection.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/21/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class Selection: NSObject {
	
	private var items = NSMutableArray()
	var boundingBox : NSRect
	
	override init() {
		boundingBox = NSRect()
	}
	
	var width : CGFloat{
		get{
			return 0
		}
	}
	
	var height : CGFloat{
		get{
			return 0
		}
	}
	
	private func computeBounds(){
		
		var lx = 999999.0
		var ly = 999999.0
		var hx = 0.0
		var hy = 0.0

		//find the least x,y and max x,y
		for genericItem in items{
			
			let item = genericItem as! Selectable
			
			let x = Double(item.x)
			let y = Double(item.y)
			let width = item.width
			let height = item.height
			
			if(x<lx){
				lx = Double(x)
			}
			
			if(y<ly){
				ly = Double(y)
			}
			
			if(x+width>hx){
				hx = x+width
			}
			
			if(y+height>hy){
				hy = y+height
			}
		}
		
		boundingBox.origin.x = CGFloat(lx)
		boundingBox.origin.y = CGFloat(ly)
		boundingBox.size.width = CGFloat(hx-lx)
		boundingBox.size.height = CGFloat(hy-ly)
		
	}
	
	public func add(item : Selectable){
		// check if item already exists
		let index = items.index(of: item)
		if(index != -1){
			return
		}
		
		items.add(item)
		computeBounds()
	}
	
	public func remove(item : Selectable){
		items.remove(item)
		computeBounds()
	}
	
}
