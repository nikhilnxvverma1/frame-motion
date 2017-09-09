//
//  Command.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/8/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

protocol Command {
	func execute()
	func unexecute()
}

