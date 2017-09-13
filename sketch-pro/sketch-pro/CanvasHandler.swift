//
//  PressDragReleaseProcessor.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Foundation
import Cocoa

protocol CanvasHandler {
	func mouseDown(with event: NSEvent,under view: DrawAreaView)
	func mouseDragged(with event: NSEvent,under view: DrawAreaView)
	func mouseUp(with event: NSEvent,under view: DrawAreaView)
}
