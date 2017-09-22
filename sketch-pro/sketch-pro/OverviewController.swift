//
//  OverviewController.swift
//  motion-frame
//
//  Created by Nikhil Verma on 8/27/17.
//  Copyright © 2017 Nikhil Verma. All rights reserved.
//

import Cocoa

class OverviewController: NSViewController,
	NSTableViewDelegate,
	NSTableViewDataSource,
	NSOutlineViewDelegate,
	NSOutlineViewDataSource,
	OverviewDelegate,
	NSFetchedResultsControllerDelegate{

	var drawAreaDelegate : DrawAreaDelegate!
	
	@IBOutlet weak var pagesTable: NSTableView!
	
	@IBOutlet weak var graphicTable: NSOutlineView!
	
	private var artboardList : [ArtboardMO]?
	
	private var pageList : [PageMO]?
	
	private var selectedPage : PageMO!
	
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
		if( pageList == nil){
			return 0
		}else{
			return pageList!.count
		}
	}
	
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		
		if( pageList == nil){
			return 0
		}else{
			return pageList![row]
		}
	}
	
	func tableView(_ tableView: NSTableView,
                viewFor tableColumn: NSTableColumn?,
                row: Int) -> NSView?{
		if let cell=tableView.make(withIdentifier: "PagesCellID", owner: nil) as? NSTableCellView{
			cell.textField?.stringValue = selectedPage.name!
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
	
	// MARK: fetching 
	
	func initializeDataModel(document:Document){
		let pageFetch = NSFetchRequest<PageMO>(entityName: "Page")
		do{
			pageList=try document.managedObjectContext?.fetch(pageFetch)
			if(pageList != nil){
				//load the contents of a previously saved document
				if(pageList!.count>1){
					selectedPage = pageList![0]
					drawAreaDelegate.loadContentFrom(artboardSet: selectedPage.artboards)
				}else{
					
					//disable undo manager
					document.managedObjectContext?.processPendingChanges()
					document.undoManager?.disableUndoRegistration()
					
					//create a new blank starting page
					selectedPage = NSEntityDescription.insertNewObject(forEntityName: "Page",
					                                    into: document.managedObjectContext!) as! PageMO

					selectedPage.name = "Page 1"
					pageList?.append(selectedPage)
					
					//reenable undo
					document.managedObjectContext?.processPendingChanges()
					document.undoManager?.enableUndoRegistration()
				}
				graphicTable.reloadData()
				pagesTable.reloadData()
				
			}
			
			
		}catch{
			fatalError("Failed to fetch pagee: \(error)")
		}
	}
	

}
