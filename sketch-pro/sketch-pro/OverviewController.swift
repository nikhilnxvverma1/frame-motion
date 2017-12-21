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
	
	var selectedPage : PageMO!
	
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
		if(tableView == pagesTable){
			if( pageList == nil){
				return 0
			}else{
				return pageList!.count
			}
		}
		return 0
	}
	
	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		if(tableView == pagesTable){
			if( pageList == nil){
				return 0
			}else{
				return pageList![row]
			}
		}
		return 0
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
		if outlineView == graphicTable{
			if let page = item as? PageMO{
				return page.artboards?.allObjects[index] as Any
			}else if let artboard = item as? ArtboardMO{
				return artboard.layers?.allObjects[index] as Any
			}else if let layer = item as? LayerMO{
				return layer as Any
			}else if item == nil {
				if pageList != nil {
					return pageList![index]
				}
			}
		}
		return 0
	}
	
	func outlineView(_ outlineView: NSOutlineView,
	                 isItemExpandable item: Any) -> Bool{
		if outlineView == graphicTable{
			if item is PageMO{
				return true
			}else if item is ArtboardMO{
				return true
			}
		}
		return false
	}
	
	func outlineView(_ outlineView: NSOutlineView,
	                 numberOfChildrenOfItem item: Any?) -> Int{
		
		if( outlineView == graphicTable){
			if let page = item as? PageMO{
				return (page.artboards?.allObjects.count)! + (page.outerLayers?.allObjects.count)!
			}else if let artboard = item as? ArtboardMO{
				return (artboard.layers?.allObjects.count)!
			}else if item == nil{
				if pageList == nil{
					return 0
				}else{
					return pageList!.count
				}
				
			}
		}
		return 0
		
	}
	
	
	//displaying table data
	func outlineView(_ outlineView: NSOutlineView,
	                 viewFor tableColumn: NSTableColumn?,
	                 item: Any) -> NSView?{
		var view:NSTableCellView?
		if outlineView == graphicTable{
			if tableColumn?.identifier == "graphicColumn"{
			
				
				view = outlineView.make(withIdentifier: "graphicCell", owner: self) as? NSTableCellView
				if let artboard = item as? ArtboardMO{
					
					
					if let textField = view?.textField{
						textField.stringValue = artboard.name!
					}
				}else if let page = item as? PageMO{
					
					if let textField = view?.textField{
						textField.stringValue = page.name!

					}
				}else if let layer = item as? LayerMO{
					
					if let textField = view?.textField{
						textField.stringValue = layer.name!
						
					}
				}
			}
		}
		return view
	}
	
	// MARK: fetching 
	
	func initializeDataModel(document:Document){
		let pageFetch = NSFetchRequest<PageMO>(entityName: "Page")
		do{
			pageList=try document.managedObjectContext?.fetch(pageFetch)
			if(pageList != nil){
				//load the contents of a previously saved document
				if(pageList!.count>0){
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
