//
//  ListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class ListViewController<VM: ListViewModel, SVM: SearchViewModel>: SimpleTableViewController where VM.ItemType == SVM.ResultType {
	
	lazy var searchController: UISearchController = {
		let resultsController = SearchResultsViewController(viewModel: searchViewModel)
		resultsController.onSelect = userDidSelectResult
		
		let searchController = UISearchController(searchResultsController: resultsController)
		searchController.searchResultsUpdater = resultsController
		
		return searchController
	}()
	
	var viewModel: VM!
	var searchViewModel: SVM!
	
	override var cellModels: [SimpleCellViewModel] {
		get { return viewModel.cellViewModels }
		set { }
		
	}
	
	init() {
		super.init(style: .plain)
	}
	
	convenience init(viewModel: VM, searchViewModel: SVM) {
		self.init()
		self.viewModel = viewModel
		self.searchViewModel = searchViewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func userDidSelectResult(result: VM.ItemType) {
		searchController.isActive = false
		viewModel.addItem(result)
		tableView.reloadData()
	}
}
