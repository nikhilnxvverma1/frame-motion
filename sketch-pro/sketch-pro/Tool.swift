//
//  Tool.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/27/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

protocol Tool {
	func didGetSelected(_ previousToolType:ToolType)
	func didGetUnselected(_ nextToolType:ToolType)
	func getToolType()->ToolType
}
