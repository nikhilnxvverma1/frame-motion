//
//  AddBezierPoint.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/9/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class AddBezierPoint: NSObject, Command {
	
	var document : Document!
	var artboardView : ArtboardView!
	var bezierPointView : BezierPointView!
	var shapeView : ShapeView!
	
	init(bezierPointView : BezierPointView,shapeView: ShapeView, artboardView:ArtboardView,document : Document) {
		super.init()
		self.bezierPointView = bezierPointView
		self.document = document
		self.artboardView = artboardView
		self.shapeView = shapeView
	}
	
	func execute(){
		persistBezierPoint()
		artboardView.addSubview(bezierPointView)
		
		if (bezierPointView.forwardControlPoint != nil){
			artboardView.addSubview(bezierPointView.forwardControlPoint)
			artboardView.addSubview(bezierPointView.forwardControlPointExtension)
		}
		
		if (bezierPointView.backwardControlPoint != nil){
			artboardView.addSubview(bezierPointView.backwardControlPoint)
			artboardView.addSubview(bezierPointView.backwardControlPointExtension)
		}
		
		hideEverythingExceptSelf(true)
		shapeView.points.last?.hideHandle(false)
		redraw()
	}
	
	func unexecute(){
		
		//view
		bezierPointView.removeFromSuperview()
		
		//model
		self.document.managedObjectContext?.delete(bezierPointView.model)
		
		if (bezierPointView.forwardControlPoint != nil){
			
			//view
			bezierPointView.forwardControlPoint.removeFromSuperview()
			bezierPointView.forwardControlPointExtension.removeFromSuperview()
			
			//model
			self.document.managedObjectContext?.delete(bezierPointView.model.controlPoint1!)
		}
		
		if (bezierPointView.backwardControlPoint != nil){
			
			//view
			bezierPointView.backwardControlPoint.removeFromSuperview()
			bezierPointView.backwardControlPointExtension.removeFromSuperview()
			
			//model
			self.document.managedObjectContext?.delete(bezierPointView.model.controlPoint2!)
		}
		
		//remove from shapeView's points list
		let index = shapeView.points.index(of: bezierPointView)
		shapeView.points.remove(at: index!)
		
		hideEverythingExceptSelf(true)
		shapeView.points.last?.hideHandle(false)
		redraw()
	}
	
	func redraw() {
		let fullRect = NSRect(x: 0, y: 0, width: shapeView.frame.width, height: shapeView.frame.height)
		shapeView.setNeedsDisplay(fullRect)
	}
	
	func hideEverythingExceptSelf(_ shouldHide:Bool){
		shapeView.hideHandles(shouldHide: shouldHide,hidePointsAlso:false)
		self.bezierPointView.hideHandle(false)
	}
	
	func persistBezierPoint(){
		
		bezierPointView.model=NSEntityDescription.insertNewObject(forEntityName: "BezierPoint",
		                                                    into: self.document.managedObjectContext!) as! BezierPointMO
		
		bezierPointView.model.x = Float(bezierPointView.x)
		bezierPointView.model.y = Float(bezierPointView.y)

		if(bezierPointView.forwardControlPoint != nil){
			bezierPointView.model.controlPoint1=NSEntityDescription.insertNewObject(forEntityName: "Point",
			                                                          into: self.document.managedObjectContext!) as? PointMO
			bezierPointView.model.controlPoint1?.x=Float(bezierPointView.forwardControlPoint.x)
			bezierPointView.model.controlPoint1?.y=Float(bezierPointView.forwardControlPoint.y)
		}
		
		if(bezierPointView.backwardControlPoint != nil){
			bezierPointView.model.controlPoint2=NSEntityDescription.insertNewObject(forEntityName: "Point",
			                                                                        into: self.document.managedObjectContext!) as? PointMO
			bezierPointView.model.controlPoint2?.x=Float(bezierPointView.backwardControlPoint.x)
			bezierPointView.model.controlPoint2?.y=Float(bezierPointView.backwardControlPoint.y)
		}
		
		// TODO: Points should be converted and be assigned to view object
		
		
		
		//add it to shape view's point list
		shapeView.points.append(bezierPointView)
		
	}
}
