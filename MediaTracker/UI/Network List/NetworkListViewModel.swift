//
//  NetworkListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class NetworkListViewModel<Input, Model>: ListViewModel where Model: Identifiable, Model: SimpleCellViewModelMappable {
	typealias ItemType = Model
	
	var results: [Model] = []
	
	var cellViewModelMapping: (Model) -> SimpleCellViewModel
	var cellViewModels: [SearchCellViewModel] = []
	var requestFactory: ((Input) -> URLRequest)
	
	let apiClient: APIClient
	
	init(apiClient: APIClient = APIClient(),
		 cellViewModelMapping: @escaping (Model) -> SimpleCellViewModel = { $0.asSimpleCellViewModel },
		 requestFactory: @escaping ((Input) -> URLRequest)) {
		
		self.apiClient = apiClient
		self.cellViewModelMapping = cellViewModelMapping
		self.requestFactory = requestFactory
	}
	
	func updateResults(for input: Input, completion: @escaping () -> Void) {
		apiClient.makeRequest(requestFactory(input)) { (result: Result<[Model]>) in
			switch result {
			case .success(let object):
				self.results = object
				self.cellViewModels = self.results.map(self.cellViewModelMapping)
				
			case .failure(let error): self.handleError(error: error)
			}
			
			completion()
		}
	}
	
	func handleError(error: Error) {
		print("ERROR: \(error.localizedDescription)")
	}

}

extension NetworkListViewModel: SearchViewModel where Input == String {
	var searchResults: [Model] { return results }
	
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void) {
		updateResults(for: searchText, completion: completion)
	}
	
	typealias ResultType = Model
	
	
}

extension NetworkListViewModel: Refreshable where Input == Void {
	func refreshData(completion: @escaping () -> Void) {
		updateResults(for: (), completion: completion)
	}
}
