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
		requestFactory: @escaping ((Input) -> URLRequest)) {
		
		self.mapping = resultMapping
		super.init(cellViewModelMapping: cellViewModelMapping,
				   requestFactory: requestFactory)
	}
	
	override func updateResults(for input: Input, completion: @escaping () -> Void) {
		apiClient.makeRequest(requestFactory(input)) { (result: Result<Wrapper>) in
			switch result {
			case .success(let wrapper):
				self.results = self.mapping(wrapper)
				self.cellViewModels = self.results.map(self.cellViewModelMapping)
			case .failure(let error):
				self.handleError(error: error)
			}
			
			completion()
		}
	}
}

extension MappingNetworkListViewModel where Wrapper == [Model] {
	convenience init(resultMapping: ((Wrapper) -> [Model])? = nil,
		 cellViewModelMapping: @escaping ((Model) -> SimpleCellViewModel) = { $0.asSimpleCellViewModel },
		 requestFactory: @escaping ((Input) -> URLRequest)) {
		
		self.init(resultMapping: resultMapping ?? { return $0 },
				  cellViewModelMapping: cellViewModelMapping,
				   requestFactory: requestFactory)
	}
}
