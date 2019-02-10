//
//  GameSearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchViewModel {
	associatedtype ResultType: SearchDisplayable
	
	var searchResults: [ResultType] { get }
	
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void)
}

struct GameSearchCellViewModel: SearchDisplayable {
	var text: String
	var detailText: String
}

class GameSearchViewModel: SearchViewModel {
	typealias ResultType = GameSearchCellViewModel
	
	var searchResults: [GameSearchCellViewModel] = []
	private var client = IGDBClient()
	
	private var dateFormatter: DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM YYYY"
		return dateFormatter
	}
	
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void) {
		client.search(query: searchText) { result in
			if case .success(let games) = result {
				self.searchResults = games.map(self.map)
				completion()
			}
		}
	}
	
	private func map(game: IGDBGame) -> GameSearchCellViewModel {
		
		return GameSearchCellViewModel(
			text: game.name,
			detailText: "Released \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(game.firstReleaseDate))))"
		)
	}
}
