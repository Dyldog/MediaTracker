//
//  ViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class SearchResultsViewController<T: SearchViewModel>: SimpleTableViewController, UISearchResultsUpdating {
	
	var viewModel: T
	
	var onSelect: ((T.ResultType) -> ())?
	
	init(viewModel: T) {
		self.viewModel = viewModel
		super.init(style: .plain)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		viewModel.updateSearchResults(for: searchController.searchBar.text ?? "") {
			self.cellModels = self.viewModel.cellViewModels
			self.tableView.reloadData()
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		onSelect?(viewModel.searchResults[indexPath.row])
	}
}
