//
//  MappingAPIClient.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 12/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Alamofire

//class MappingAPIClient<WrapperModel, ResultModel>: APIClient where WrapperModel: Codable {
//	var mapping: (WrapperModel) -> ResultModel
//	
//	init(mapping: @escaping (WrapperModel) -> ResultModel) {
//		self.mapping = mapping
//	}
//	
//	func makeRequest(_ request: URLRequest, completion: @escaping ((Result<ResultModel>) -> Void)) {
//		makeRequest(request) { (result: Result<WrapperModel>) in
//			switch result {
//			case .success(let wrapper): completion(.success(self.mapping(wrapper)))
//			case .failure(let error): completion(.failure(error))
//			}
//		}
//	}
//}
