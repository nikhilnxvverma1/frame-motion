//
//  PressDragReleaseProcessor.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 8/31/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Foundation
import Cocoa

protocol PressDragReleaseProcessor {
	func mouseDown(with event: NSEvent,under view: NSScrollView)
	func mouseDragged(with event: NSEvent,under view: NSScrollView)
	func mouseUp(with event: NSEvent,under view: NSScrollView)
}
