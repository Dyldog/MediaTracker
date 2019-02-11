//
//  ViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class SearchResultsViewController<T: SearchViewModel>: SimpleTableViewController, UISearchResultsUpdating {
	
//	var searchBar: UISearchBar!
	var viewModel: T
	
	var onSelect: ((T.ResultType) -> ())?
	
	init(viewModel: T) {
		self.viewModel = viewModel
		super.init(style: .plain)
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.rowHeight = UITableView.automaticDimension
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
//		initSearchBar()
	}
	
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//		searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
//	}
	
//	private func initSearchBar() {
//		searchBar = UISearchBar()
//		searchBar.translatesAutoresizingMaskIntoConstraints = false
//
//		searchBar.delegate = self
//		tableView.tableHeaderView = searchBar
//	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.updateSearchResults(for: searchBar.text ?? "") {
			self.cellModels = self.viewModel.cellViewModels
			self.tableView.reloadData()
		}
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		searchBar(searchController.searchBar, textDidChange: searchController.searchBar.text ?? "")
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		onSelect?(viewModel.searchResults[indexPath.row])
	}
	
	@objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
//	@objc override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		searchBar.resignFirstResponder()
//	}

}
