//
//  BezierPointView.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/26/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class BezierPointView: NSView {
	
	var model : BezierPointMO!
	var _x : CGFloat!
	var _y : CGFloat!
	var x: CGFloat {
		get {
			return _x
		}
		set(newValue) {
			_x = newValue
			self.frame.origin.x = _x - self.frame.size.width/2
		}
	}
	
	var y: CGFloat {
		get {
			return _y
		}
		set(newValue) {
			_y = newValue
			self.frame.origin.y = _y - self.frame.size.height/2
		}
	}
	
	var forwardControlPoint : ControlPointView!
	var backwardControlPoint : ControlPointView!
	var forwardControlPointExtension : ControlPointExtension!
	var backwardControlPointExtension : ControlPointExtension!
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.frame.size.width = 5
		self.frame.size.height = 5
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
		NSColor.blue.setFill()
		NSRectFill(dirtyRect)
		super.draw(dirtyRect)
    }
	
	func hideHandle(_ shouldHide:Bool){
		
		if(self.backwardControlPoint != nil){
			self.backwardControlPoint.isHidden = shouldHide
			self.backwardControlPointExtension.isHidden = shouldHide
		}
		
		if(self.forwardControlPoint != nil){
			self.forwardControlPoint.isHidden = shouldHide
			self.forwardControlPointExtension.isHidden = shouldHide
		}
	}
    
}
