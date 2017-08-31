//
//  Workspace.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

enum Tool{
	case Selection
	case Artboard
	case Rectangle
	case Circle
}

class Workspace: NSObject {
	var current : Tool = .Selection
}
