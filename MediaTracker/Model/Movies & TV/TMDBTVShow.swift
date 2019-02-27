//
//  TMDBTVShow.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 13/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let tMDBSearchResponse = try? newJSONDecoder().decode(TMDBSearchResponse.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTMDBSearchResponse { response in
//     if let tMDBSearchResponse = response.result.value {
//       ...
//     }
//   }
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation
import Alamofire

struct TMDBTVShow: Codable, Equatable {
	let originalName: String
	let id: Int
	let name: String
	let voteCount: Int
	let voteAverage: Double
	let posterPath: String?
	let firstAirDate: String
	let popularity: Double
	let genreIDS: [Int]
	let originalLanguage: String
	let backdropPath: String?
	let overview: String
	let originCountry: [String]
	
	enum CodingKeys: String, CodingKey {
		case originalName = "original_name"
		case id = "id"
		case name = "name"
		case voteCount = "vote_count"
		case voteAverage = "vote_average"
		case posterPath = "poster_path"
		case firstAirDate = "first_air_date"
		case popularity = "popularity"
		case genreIDS = "genre_ids"
		case originalLanguage = "original_language"
		case backdropPath = "backdrop_path"
		case overview = "overview"
		case originCountry = "origin_country"
	}
}

fileprivate func newJSONDecoder() -> JSONDecoder {
	let decoder = JSONDecoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		decoder.dateDecodingStrategy = .iso8601
	}
	return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
	let encoder = JSONEncoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		encoder.dateEncodingStrategy = .iso8601
	}
	return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
	fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
		return DataResponseSerializer { _, response, data, error in
			guard error == nil else { return .failure(error!) }
			
			guard let data = data else {
				return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
			}
			
			return Result { try newJSONDecoder().decode(T.self, from: data) }
		}
	}
	
	@discardableResult
	fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
		return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
	}
	
	@discardableResult
	func responseTMDBSearchResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<TMDBSearchResponse<TMDBTVShow>>) -> Void) -> Self {
		return responseDecodable(queue: queue, completionHandler: completionHandler)
	}
}

extension TMDBTVShow: Identifiable {
	var identifier: String { return "\(id)" }
}

extension TMDBTVShow: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return .init(imageURL: nil, text: name, detailText: overview, identifier: identifier)
	}
}
