//
//  OverviewController.swift
//  motion-frame
//
//  Created by Nikhil Verma on 8/27/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class OverviewController: NSViewController,NSTableViewDelegate,NSTableViewDataSource, NSOutlineViewDelegate,NSOutlineViewDataSource,OverviewDelegate {

	var drawAreaDelegate : DrawAreaDelegate!
	
	@IBOutlet weak var pagesTable: NSTableView!
	
	@IBOutlet weak var graphicTable: NSOutlineView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		pagesTable!.dataSource=self
		pagesTable!.delegate=self
		
		graphicTable.delegate=self
		graphicTable.dataSource=self
    }
	
	// MARK: Table View
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		
		let label = NSString.localizedStringWithFormat("Row %d", row)
		return label
	}
	
	func tableView(_ tableView: NSTableView,
                viewFor tableColumn: NSTableColumn?,
                row: Int) -> NSView?{
		if let cell=tableView.make(withIdentifier: "PagesCellID", owner: nil) as? NSTableCellView{
			cell.textField?.stringValue="Row \(row)"
			return cell
		}else{
			return nil
		}
	}
	
	func selectionShouldChange(in tableView: NSTableView) -> Bool{
		return true
	}
	
	func tableView(_ tableView: NSTableView,
	               shouldSelectRow row: Int) -> Bool{
		return true
	}
	
	// MARK: Outline View
	
	func outlineView(_ outlineView: NSOutlineView,
	                 child index: Int,
	                 ofItem item: Any?) -> Any{
		return index
	}
	
	func outlineView(_ outlineView: NSOutlineView,
	                 isItemExpandable item: Any) -> Bool{
		return false
	}
	
	func outlineView(_ outlineView: NSOutlineView,
	                 numberOfChildrenOfItem item: Any?) -> Int{
		if(item != nil) {
			return 0
		}else{
			return 3
		}
	}
	
	func outlineView(_ outlineView: NSOutlineView,
	                 objectValueFor tableColumn: NSTableColumn?,
	                 byItem item: Any?) -> Any?{
		return nil
	}

}
