//
//  ArtboardHandler.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/13/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

protocol ArtboardHandler {
	func mouseDown(with event: NSEvent,under view: ArtboardView)
	func mouseDragged(with event: NSEvent,under view: ArtboardView)
	func mouseUp(with event: NSEvent,under view: ArtboardView)
}
