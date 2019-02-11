//
//  GameListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class GameListViewModel {
	private var storageManager = StorageManager()
	lazy var cellViewModels: [SimpleCellViewModel] = storageManager.games.map(map)
	
	private var dateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM YYYY"
		return dateFormatter
	}
	
	private func map(game: IGDBGame) -> SearchCellViewModel {
		return SearchCellViewModel(
			text: game.name,
			detailText: "Released \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(game.firstReleaseDate))))"
		)
	}
	
	func addGame(_ game: IGDBGame) {
		storageManager.games.append(game)
		cellViewModels.append(map(game: game))
	}
	
	func removeGame(at index: Int) {
		storageManager.games.remove(at: index)
		cellViewModels.remove(at: index)
	}
}
