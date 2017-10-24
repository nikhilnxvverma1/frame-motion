//
//  Selectable.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/21/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

protocol Selectable {
	
	var x : Double { get }
	var y : Double { get }
	var width : Double { get }
	var height : Double { get }
	var boundingBox : NSRect { get }
	
	func didGetSelected()
	func didGetUnselected()
	
	func enteredDetailSelection()
	func exitedDetailSelection()
}

