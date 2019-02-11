//
//  APISearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class APISearchViewModel<ResultModel>: SearchViewModel where ResultModel: Identifiable, ResultModel: SimpleCellViewModelMappable {
	
	var searchResults: [ResultModel] = []
	
	var cellViewModelMapping: (ResultModel) -> SimpleCellViewModel
	var cellViewModels: [SearchCellViewModel] = []
	var searchRequestFactory: ((String) -> URLRequest)
	
	let apiClient = APIClient()
	
	init(cellViewModelMapping: @escaping (ResultModel) -> SimpleCellViewModel, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		self.cellViewModelMapping = cellViewModelMapping
		self.searchRequestFactory = searchRequestFactory
	}
	
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void) {
		apiClient.makeRequest(searchRequestFactory(searchText)) { result in
			switch result {
			case .success(let data):
				self.searchResults = (try? JSONDecoder().decode([ResultModel].self, from: data)) ?? []
				self.cellViewModels = self.searchResults.map(self.cellViewModelMapping)
				
			default: break
			}
			
			completion()
		}
	}
}
