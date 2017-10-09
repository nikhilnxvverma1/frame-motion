//
//  CompositeCommand.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 10/9/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class CompositeCommand: NSObject,Command {

	var commandList = [Command]()
	
	func execute(){
		for command in commandList{
			command.execute()
		}
	}
	
	func unexecute(){
		for command in commandList{
			command.unexecute()
		}
	}
}
