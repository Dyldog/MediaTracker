//
//  GameListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class StorageManager {
	static let gamesKey = "GAMES"
	
	var games: [IGDBGame] = [] {
		didSet { saveGames() }
	}
	
	init() {
		loadGames()
	}
	
	func loadGames() {
		if let gameData = UserDefaults.standard.data(forKey: StorageManager.gamesKey) {
			games = (try? JSONDecoder().decode([IGDBGame].self, from: gameData)) ?? []
		}
	}
	
	func saveGames() {
		UserDefaults.standard.set(try! JSONEncoder().encode(games), forKey: StorageManager.gamesKey)
	}
}

class GameListViewController: SimpleTableViewController {
	
	var searchController: UISearchController
	var viewModel = GameListViewModel()
	override var cellModels: [SimpleCellViewModel] {
		get { return viewModel.cellViewModels }
		set { }
		
	}
	
	init() {
		let resultsController = SearchResultsController(viewModel: GameSearchViewModel())
		searchController = UISearchController(searchResultsController: resultsController)
		searchController.searchResultsUpdater = resultsController
		
		super.init(style: .plain)
		
		resultsController.onSelect = userDidSelectResult
		
		navigationItem.searchController = searchController
		definesPresentationContext = true
		
		self.title = "Games"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func userDidSelectResult(result: IGDBGame) {
		searchController.isActive = false
		viewModel.addGame(result)
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			viewModel.removeGame(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
}
