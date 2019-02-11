//
//  APISearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class APISearchViewModel<T>: SearchViewModel where T: Identifiable, T: SimpleCellViewModelMappable {
	
	var searchResults: [T] = []
	var cellViewModels: [SearchCellViewModel] = []
	var searchRequestFactory: ((String) -> URLRequest)
	
	let apiClient = APIClient()
	
	init(searchRequestFactory: @escaping ((String) -> URLRequest)) {
		self.searchRequestFactory = searchRequestFactory
	}
	
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void) {
		apiClient.makeRequest(searchRequestFactory(searchText)) { result in
			switch result {
			case .success(let data):
				self.searchResults = (try? JSONDecoder().decode([T].self, from: data)) ?? []
				self.cellViewModels = self.searchResults.map { $0.asSimpleCellViewModel }
				
			default: break
			}
			
			completion()
		}
	}
}
