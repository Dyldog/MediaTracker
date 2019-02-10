//
//  ViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit
protocol SearchDisplayable {
	var text: String { get }
	var detailText: String { get }
}

class SearchViewController<T: SearchViewModel>: UITableViewController, UISearchBarDelegate {
	
	var searchBar: UISearchBar!
	var viewModel: T
	
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
		initSearchBar()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
	}
	
	private func initSearchBar() {
		searchBar = UISearchBar()
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		
		searchBar.delegate = self
		tableView.tableHeaderView = searchBar
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		viewModel.updateSearchResults(for: searchBar.text ?? "") {
			self.tableView.reloadData()
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.searchResults.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		cell.detailTextLabel?.numberOfLines = 0
		return cell
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cellModel = viewModel.searchResults[indexPath.row]
		
		cell.textLabel?.text = cellModel.text
		cell.detailTextLabel?.text = cellModel.detailText
	}
	
	@objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	@objc override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		searchBar.resignFirstResponder()
	}

}
