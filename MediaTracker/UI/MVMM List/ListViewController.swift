//
//  ListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class ListViewController<VM: ListViewModel>: SimpleTableViewController {
	
	var viewModel: VM!
	
	override var cellModels: [SimpleCellViewModel] {
		get { return viewModel.cellViewModels }
		set { fatalError() }
		
	}
	
	init() {
		super.init(style: .plain)
	}
	
	convenience init(viewModel: VM) {
		self.init()
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
