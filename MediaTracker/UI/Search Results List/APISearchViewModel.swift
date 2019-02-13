//
//  APISearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class APISearchViewModel<ResultModel>: SearchViewModel where ResultModel: Identifiable, ResultModel: SimpleCellViewModelMappable {
	
	var searchResults: [ResultModel] = []
	
	var cellViewModelMapping: (ResultModel) -> SimpleCellViewModel
	var cellViewModels: [SearchCellViewModel] = []
	var searchRequestFactory: ((String) -> URLRequest)
	
	let apiClient: APIClient
	
	init(apiClient: APIClient = APIClient(), cellViewModelMapping: @escaping (ResultModel) -> SimpleCellViewModel, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		self.apiClient = apiClient
		self.cellViewModelMapping = cellViewModelMapping
		self.searchRequestFactory = searchRequestFactory
	}
	
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void) {
		apiClient.makeRequest(searchRequestFactory(searchText)) { (result: Result<[ResultModel]>) in
			switch result {
			case .success(let object):
				self.searchResults = object
				self.cellViewModels = self.searchResults.map(self.cellViewModelMapping)
				
			default: break
			}
			
			completion()
		}
	}
}

class MappingAPISearchViewModel<WrapperModel, ResultModel>: APISearchViewModel<ResultModel> where ResultModel: Identifiable, ResultModel: SimpleCellViewModelMappable, WrapperModel: Codable  {
	var mapping: (WrapperModel) -> [ResultModel]
	
	init(searchResultMapping: @escaping (WrapperModel) -> [ResultModel], cellViewModelMapping: @escaping (ResultModel) -> SimpleCellViewModel, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		self.mapping = searchResultMapping
		super.init(cellViewModelMapping: cellViewModelMapping, searchRequestFactory: searchRequestFactory)
	}
	
	override func updateSearchResults(for searchText: String, completion: @escaping () -> Void) {
		apiClient.makeRequest(searchRequestFactory(searchText), completion: { (result: Result<WrapperModel>) in
			switch result {
			case .success(let wrapper):
				self.searchResults = self.mapping(wrapper)
				self.cellViewModels = self.searchResults.map(self.cellViewModelMapping)
			default: break
			}
			
			completion()
		})
			
//			.makeRequest(searchRequestFactory(searchText)) { (result: Result<[Wra]>) in
//			switch result {
//			case .success(let object):
//				self.searchResults = object
//				self.cellViewModels = self.searchResults.map(self.cellViewModelMapping)
//
//			default: break
//			}
//
//			completion()
//		}
	}
}
