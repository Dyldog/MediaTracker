//
//  NetworkStoredListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class NetworkStoredListViewModel<Model: SimpleCellViewModelMappable>: ListViewModel, Refreshable {
	
	typealias ItemType = Model
	
	var cellViewModels: [SimpleCellViewModel] = []
	
	var apiClient: APIClient
	
	init(apiClient: APIClient = APIClient()) {
		self.apiClient = apiClient
	}
	
	func refreshData(completion: () -> Void) {
		completion()
	}
}
