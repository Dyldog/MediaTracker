//
//  MutableListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import UIKit

class MutableListViewController<VM: MutableListViewModel, SVM: SearchViewModel>: ListViewController<VM> where VM.ItemType == SVM.ResultType {
	
	lazy var searchController: UISearchController = {
		let resultsController = SearchResultsViewController(viewModel: searchViewModel)
		resultsController.onSelect = userDidSelectResult
		
		let searchController = UISearchController(searchResultsController: resultsController)
		searchController.searchResultsUpdater = resultsController
		
		return searchController
	}()
	
	var searchViewModel: SVM!
	
	init(viewModel: VM, searchViewModel: SVM) {
		super.init()
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
