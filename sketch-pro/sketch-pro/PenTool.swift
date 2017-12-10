//
//  PenTool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/26/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa
import Foundation

class PenTool: NSObject, CanvasHandler, ArtboardHandler, Tool {
	
	var document : Document!
	var shapeView : ShapeView!
	var latestBezierPointView : BezierPointView!
	var latestInitialPoint : NSPoint!
	static var shapeCount = 0
	private var addBezierPoint : AddBezierPoint?
	
	init (_ document : Document){
		self.document = document
	}
	
	// MARK: Scroll View Canvas
	
	func mouseDown(with event: NSEvent,under view: DrawAreaView){
		// TODO: remove if not needed
	}
	
	func mouseDragged(with event: NSEvent,under view: DrawAreaView){
		// TODO: remove if not needed
	}
	
	func mouseUp(with event: NSEvent,under view: DrawAreaView){
		// TODO: remove if not needed
	}
	
	// MARK: Artboard
	
	func mouseDown(with event: NSEvent,artboardView: ArtboardView){
		
		// remove previous control point gadget if any
		if( latestBezierPointView != nil && latestBezierPointView.forwardControlPoint != nil ){
			latestBezierPointView.forwardControlPoint.removeFromSuperview()
			latestBezierPointView.backwardControlPoint.removeFromSuperview()
			
			latestBezierPointView.forwardControlPointExtension.removeFromSuperview()
			latestBezierPointView.backwardControlPointExtension.removeFromSuperview()
		}
		
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		latestInitialPoint = localPoint
		latestBezierPointView = BezierPointView()
		latestBezierPointView.x = localPoint.x
		latestBezierPointView.y = localPoint.y
		artboardView.addSubview(latestBezierPointView)
		
		if(shapeView != nil){
			//Use only the bezier point command
			addBezierPoint = AddBezierPoint(bezierPointView: latestBezierPointView,shapeView: shapeView, artboardView: artboardView, document: document)
//			addBezierPoint.persistBezierPoint()
			
			//push the comm and on the stack
			self.document.workspace.pushCommand(command: addBezierPoint, executeBeforePushing: false)
		}
		
	}
	
	func mouseDragged(with event: NSEvent,artboardView: ArtboardView){
		let localPoint = artboardView.convert(event.locationInWindow, from : nil)
		
		// initialize forward and backward control point if they don't already exist
		if( latestBezierPointView.forwardControlPoint==nil ){
			latestBezierPointView.forwardControlPoint = ControlPointView()
			latestBezierPointView.backwardControlPoint = ControlPointView()
			artboardView.addSubview(latestBezierPointView.forwardControlPoint)
			artboardView.addSubview(latestBezierPointView.backwardControlPoint)
			
			//attach control point extension lines from anchor point to control point
			latestBezierPointView.forwardControlPointExtension = ControlPointExtension()
			latestBezierPointView.backwardControlPointExtension = ControlPointExtension()
			artboardView.addSubview(latestBezierPointView.forwardControlPointExtension)
			artboardView.addSubview(latestBezierPointView.backwardControlPointExtension)
			
			//connect the extension lines from bezier anchor point to control points
			latestBezierPointView.forwardControlPointExtension.bezierPoint=latestBezierPointView
			latestBezierPointView.forwardControlPointExtension.controlPoint=latestBezierPointView.forwardControlPoint
			latestBezierPointView.backwardControlPointExtension.bezierPoint=latestBezierPointView
			latestBezierPointView.backwardControlPointExtension.controlPoint=latestBezierPointView.backwardControlPoint
		}
		
		// move forward control point to where local point is 
		latestBezierPointView.forwardControlPoint.x = localPoint.x
		latestBezierPointView.forwardControlPoint.y = localPoint.y

		//find the angle that the latest Initial point makes with this point
		let originAngle = angle(from: latestInitialPoint, to: localPoint)
		let supplememntryAngle = addAngle(Int(originAngle), angle2: 180)

		
		//find the distance between latest initial point and local point
		let distance = sqrt((localPoint.x-latestInitialPoint.x)*(localPoint.x-latestInitialPoint.x) + (localPoint.y-latestInitialPoint.y)*(localPoint.y-latestInitialPoint.y))
		
		//inverse control point
		let inversePoint = pointAtDistance(latestInitialPoint , supplememntryAngle, Double(distance))
		
		// move backward control point at the inverse direction i.e 180 degrees
		latestBezierPointView.backwardControlPoint.x = inversePoint.x
		latestBezierPointView.backwardControlPoint.y = inversePoint.y

		//take care of the frame of the extension lines
		reposition(extensionLine: latestBezierPointView.forwardControlPointExtension)
		reposition(extensionLine: latestBezierPointView.backwardControlPointExtension)
		
		if(shapeView != nil){
			shapeView.computeBounds()
		}
		
	}
	
	func mouseUp(with event: NSEvent,artboardView: ArtboardView){
		
		if(shapeView==nil){
			
			//new shape command
			let name = "Path \(PenTool.shapeCount)"
			PenTool.shapeCount+=1
			shapeView = ShapeView()
//			shapeView.frame.origin.x = latestBezierPointView.x
//			shapeView.frame.origin.y = latestBezierPointView.y
			let createShape = AddShapeLayer(shapeView: shapeView, artboardView: artboardView, document: self.document, name: name)
			document.workspace.itemList.add(shapeView)
			createShape.createAndPersistShape()
			artboardView.addSubview(shapeView)
			
			//create add bezier point command
			let addBezierPoint = AddBezierPoint(bezierPointView: latestBezierPointView,shapeView: shapeView, artboardView: artboardView, document: document)
			addBezierPoint.persistBezierPoint()
			
			// Combine these two commands together
			let createShapeAndAddPoint = CompositeCommand()
			createShapeAndAddPoint.commandList.append(createShape)
			createShapeAndAddPoint.commandList.append(addBezierPoint)
			
			//push the comm and on the stack
			self.document.workspace.pushCommand(command: createShapeAndAddPoint, executeBeforePushing: false)
			
			//refresh table
			self.document.workspace.windowController.overviewController.graphicTable.reloadData()
			
		}else{
//			//Use only the bezier point command
//			let addBezierPoint = AddBezierPoint(bezierPointView: latestBezierPointView,shapeView: shapeView, artboardView: artboardView, document: document)
//			addBezierPoint.persistBezierPoint()
//			
//			//push the comm and on the stack
//			self.document.workspace.pushCommand(command: addBezierPoint, executeBeforePushing: false)
			addBezierPoint!.persistBezierPoint()
		}
		
		shapeView.computeBounds()

	}
	
	
	func reposition(extensionLine:ControlPointExtension){
		
		let cx = extensionLine.controlPoint.frame.origin.x
		let cy = extensionLine.controlPoint.frame.origin.y
		let ax = extensionLine.bezierPoint.frame.origin.x
		let ay = extensionLine.bezierPoint.frame.origin.y
		
		//set the frame of the extension line
		extensionLine.frame.size.width = abs(ax-cx)
		extensionLine.frame.size.height = abs(ay-cy)
		
		// first quadrant
		if (cx>=ax && cy>=ay){
			extensionLine.frame.origin.x = ax
			extensionLine.frame.origin.y = ay
		}
			
			// second quadrant
		else if (cx<=ax && cy>=ay){
			extensionLine.frame.origin.x = cx
			extensionLine.frame.origin.y = ay
		}
			
			// third quadrant
		else if (cx<=ax && cy<=ay){
			extensionLine.frame.origin.x = cx
			extensionLine.frame.origin.y = cy
		}
			
			// fourth quadrant
		else if (cx>=ax && cy<=ay){
			extensionLine.frame.origin.x = ax
			extensionLine.frame.origin.y = cy
		}
		
		//force redraw
		extensionLine.needsDisplay = true
		
	}
	
	
	private func angle(from:NSPoint,to:NSPoint)->Double{
		var angle = 0.0
		if(from.y > to.y){
			if(from.x<to.x){
				//first quadrant
				let ratio = (from.y - to.y)/(from.x - to.x)
				//first quadrant is below the x axis, therefore angle comes to be negative
				angle = abs(Double(atan(ratio) * 180/CGFloat.pi))
			}else{
				//second quadrant
				let ratio = (from.y - to.y)/(to.x - from.x)
				//second quadrant is below the x axis, therefore angle atan comes to be negative
				angle = 180 - abs(Double(atan(ratio) * 180/CGFloat.pi))
			}
		}else{
			if(from.x>to.x){
				//third quadrant
				let ratio = (to.y - from.y)/(from.x - to.x)
				angle = 180 + Double(atan(ratio) * 180/CGFloat.pi)
			}else{
				//fourth quadrant
				let ratio = (to.y - from.y)/(to.x - from.x)
				angle = 360 - Double(atan(ratio) * 180/CGFloat.pi)
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
		let radAngle = Double(angle)*Double(Double.pi/180)
		distantPoint.x = origin.x + CGFloat(distance * cos(radAngle))
		distantPoint.y = origin.y - CGFloat(distance * sin(radAngle))
		return distantPoint
	}
	
	// MARK: Tool functions
	
	func didGetSelected(_ previousToolType:ToolType){
		
	}
	
	func didGetUnselected(_ nextToolType:ToolType){
		
		if(shapeView==nil){
			return
		}
		
		// close the figure if needed
		
		// clear the previous selection list
		document.workspace.selectionArea.removeAllObjects()
		
		// add only this shape to the selection group
		document.workspace.selectionArea.add(item: shapeView)
		
	}
	
	func getToolType()->ToolType{
		return ToolType.Pen
	}

}
