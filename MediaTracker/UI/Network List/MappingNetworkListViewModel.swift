//
//  MappingNetworkListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class MappingNetworkListViewModel<Input, Wrapper, Model>: NetworkListViewModel<Input, Model>
where Wrapper: Codable, Model: Identifiable, Model: SimpleCellViewModelMappable {
	
	var mapping: (Wrapper) -> [Model]

	
	init(resultMapping: @escaping (Wrapper) -> [Model],
		cellViewModelMapping: @escaping ((Model) -> SimpleCellViewModel) = { $0.asSimpleCellViewModel },
		searchRequestFactory: @escaping ((Input) -> URLRequest)) {
		
		self.mapping = resultMapping
		super.init(cellViewModelMapping: cellViewModelMapping,
				   requestFactory: searchRequestFactory)
	}
	
	override func updateResults(for input: Input, completion: @escaping () -> Void) {
		apiClient.makeRequest(requestFactory(input)) { (result: Result<Wrapper>) in
			switch result {
			case .success(let wrapper):
				self.results = self.mapping(wrapper)
				self.cellViewModels = self.results.map(self.cellViewModelMapping)
			default: break
			}
			
			completion()
		}
	}
}
