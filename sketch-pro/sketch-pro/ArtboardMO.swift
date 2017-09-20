//
//  ArtboardMO.swift
//  sketch-pro
//
//  Created by Nikhil Verma on 9/19/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class ArtboardMO: NSManagedObject {
	@NSManaged var x : Float
	@NSManaged var y : Float
	@NSManaged var width : Float
	@NSManaged var height : Float
}
