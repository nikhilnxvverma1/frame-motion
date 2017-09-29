//
//  PenTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/26/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa
import Foundation

class PenTool: NSObject, CanvasHandler, ArtboardHandler {
	
	var document : Document!
	var graphicView : GraphicView!
	var bezierPoints = [BezierPointMO]()
	var latestBezierPointView : BezierPointView!
	
	init (_ document : Document){
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
		latestBezierPointView = BezierPointView()
		latestBezierPointView.x = Float(localPoint.x)
		latestBezierPointView.y = Float(localPoint.y)
		latestBezierPointView.frame.origin.x = localPoint.x - latestBezierPointView.frame.width/2
		latestBezierPointView.frame.origin.y = localPoint.y - latestBezierPointView.frame.height/2
		artboardView.addSubview(latestBezierPointView)
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		
		// initialize forward and backward control point if they don't already exist
		if( latestBezierPointView.forwardControlPoint==nil ){
			latestBezierPointView.forwardControlPoint = ControlPointView()
			latestBezierPointView.backwardControlPoint = ControlPointView()
			artboardView.addSubview(latestBezierPointView.forwardControlPoint)
			artboardView.addSubview(latestBezierPointView.backwardControlPoint)
		}
		
		// move forward control point to where local point is 
		latestBezierPointView.forwardControlPoint.x = Float(localPoint.x)
		latestBezierPointView.forwardControlPoint.y = Float(localPoint.y)
		latestBezierPointView.forwardControlPoint.frame.origin.x = localPoint.x - latestBezierPointView.forwardControlPoint.frame.width/2
		latestBezierPointView.forwardControlPoint.frame.origin.y = localPoint.y - latestBezierPointView.forwardControlPoint.frame.height/2
		
		// move backward control point at the inverse direction i.e 180 degrees
		
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		
//		self.document.workspace.pushCommand(command: command, executeBeforePushing: false)
	}
	
	private func angle(from:NSPoint,to:NSPoint)->Double{
		var angle = 0.0
		if(from.y > to.y){
			if(from.x>to.x){
				//first quadrant
				let ratio = (from.y - to.y)/(from.x - to.x)
				angle = Double(atan(ratio) * 180/CGFloat.pi)
			}else{
				//second quadrant
				let ratio = (from.y - to.y)/(to.x - from.x)
				angle = 90 + Double(atan(ratio) * 180/CGFloat.pi)
			}
		}else{
			if(from.x<to.x){
				//third quadrant
				let ratio = (to.y - from.y)/(from.x - to.x)
				angle = 180 + Double(atan(ratio) * 180/CGFloat.pi)
			}else{
				//fourth quadrant
				let ratio = (to.y - from.y)/(to.x - from.x)
				angle = 270 + Double(atan(ratio) * 180/CGFloat.pi)
			}
		}
		return angle
	}
	
	private func addAngle(_ angle1:Int,angle2:Int) -> Int{
		if (angle1 + angle2 < 0){
			return 360 + (angle1+angle2)
		}else if(angle1 + angle2 > 360){
			return (angle1+angle2) % 360
		}else{
			return angle1 + angle2
		}
	}
	
	private func pointAtDistance(_ origin:NSPoint,_ angle:Int,_ distance:Double) -> NSPoint{
		var distantPoint = NSPoint()
		// TODO test
		distantPoint.x = origin.x + CGFloat(distance * cos(Double(angle)*Double(Double.pi/180)))
		distantPoint.y = origin.y + CGFloat(distance * sin(Double(angle)*Double(Double.pi/180)))
		return distantPoint
	}

}
