//
//  IGDBMovie.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//
// GENERATED FROM https://app.quicktype.io

// To parse the JSON, add this file to your project and do:
//
//   let iGDBGame = try IGDBGame(json)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseIGDBGame { response in
//     if let iGDBGame = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

struct IGDBGame: Codable {
	
	let id: Int
	let name: String
	let summary: String?
	let firstReleaseDate: Int?
	
	let ageRatings: [Int]?
	let aggregatedRating: Double?
	let aggregatedRatingCount, category, collection, cover: Int?
	let createdAt: Int?
	let externalGames: [Int]?
	let gameModes, genres: [Int]?
	let hypes: Int?
	let involvedCompanies, keywords: [Int]?
	let platforms, playerPerspectives: [Int]?
	let popularity, rating: Double?
	let ratingCount: Int?
	let releaseDates, screenshots, similarGames: [Int]?
	let slug: String
	let tags, themes: [Int]?
	let totalRating: Double?
	let totalRatingCount, updatedAt: Int?
	let url: String?
	let videos, websites: [Int]?
	
	enum CodingKeys: String, CodingKey {
		case id
		case ageRatings = "age_ratings"
		case aggregatedRating = "aggregated_rating"
		case aggregatedRatingCount = "aggregated_rating_count"
		case category, collection, cover
		case createdAt = "created_at"
		case externalGames = "external_games"
		case firstReleaseDate = "first_release_date"
		case gameModes = "game_modes"
		case genres, hypes
		case involvedCompanies = "involved_companies"
		case keywords, name, platforms
		case playerPerspectives = "player_perspectives"
		case popularity, rating
		case ratingCount = "rating_count"
		case releaseDates = "release_dates"
		case screenshots
		case similarGames = "similar_games"
		case slug, summary, tags, themes
		case totalRating = "total_rating"
		case totalRatingCount = "total_rating_count"
		case updatedAt = "updated_at"
		case url, videos, websites
	}
}

// MARK: Convenience initializers and mutators

extension IGDBGame {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(IGDBGame.self, from: data)
	}
	
	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}
	
	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}
	
//	func with(
//		id: Int?? = nil,
//		ageRatings: [Int]?? = nil,
//		aggregatedRating: Double?? = nil,
//		aggregatedRatingCount: Int?? = nil,
//		category: Int?? = nil,
//		collection: Int?? = nil,
//		cover: Int?? = nil,
//		createdAt: Int?? = nil,
//		externalGames: [Int]?? = nil,
//		firstReleaseDate: Int?? = nil,
//		gameModes: [Int]?? = nil,
//		genres: [Int]?? = nil,
//		hypes: Int?? = nil,
//		involvedCompanies: [Int]?? = nil,
//		keywords: [Int]?? = nil,
//		name: String?? = nil,
//		platforms: [Int]?? = nil,
//		playerPerspectives: [Int]?? = nil,
//		popularity: Double?? = nil,
//		rating: Double?? = nil,
//		ratingCount: Int?? = nil,
//		releaseDates: [Int]?? = nil,
//		screenshots: [Int]?? = nil,
//		similarGames: [Int]?? = nil,
//		slug: String?? = nil,
//		summary: String?? = nil,
//		tags: [Int]?? = nil,
//		themes: [Int]?? = nil,
//		totalRating: Double?? = nil,
//		totalRatingCount: Int?? = nil,
//		updatedAt: Int?? = nil,
//		url: String?? = nil,
//		videos: [Int]?? = nil,
//		websites: [Int]?? = nil
//		) -> IGDBGame {
//		return IGDBGame(
//			id: id ?? self.id,
//			ageRatings: ageRatings ?? self.ageRatings,
//			aggregatedRating: aggregatedRating ?? self.aggregatedRating,
//			aggregatedRatingCount: aggregatedRatingCount ?? self.aggregatedRatingCount,
//			category: category ?? self.category,
//			collection: collection ?? self.collection,
//			cover: cover ?? self.cover,
//			createdAt: createdAt ?? self.createdAt,
//			externalGames: externalGames ?? self.externalGames,
//			firstReleaseDate: firstReleaseDate ?? self.firstReleaseDate,
//			gameModes: gameModes ?? self.gameModes,
//			genres: genres ?? self.genres,
//			hypes: hypes ?? self.hypes,
//			involvedCompanies: involvedCompanies ?? self.involvedCompanies,
//			keywords: keywords ?? self.keywords,
//			name: name ?? self.name,
//			platforms: platforms ?? self.platforms,
//			playerPerspectives: playerPerspectives ?? self.playerPerspectives,
//			popularity: popularity ?? self.popularity,
//			rating: rating ?? self.rating,
//			ratingCount: ratingCount ?? self.ratingCount,
//			releaseDates: releaseDates ?? self.releaseDates,
//			screenshots: screenshots ?? self.screenshots,
//			similarGames: similarGames ?? self.similarGames,
//			slug: slug ?? self.slug,
//			summary: summary ?? self.summary,
//			tags: tags ?? self.tags,
//			themes: themes ?? self.themes,
//			totalRating: totalRating ?? self.totalRating,
//			totalRatingCount: totalRatingCount ?? self.totalRatingCount,
//			updatedAt: updatedAt ?? self.updatedAt,
//			url: url ?? self.url,
//			videos: videos ?? self.videos,
//			websites: websites ?? self.websites
//		)
//	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
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
	func responseIGDBGame(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<IGDBGame>) -> Void) -> Self {
		return responseDecodable(queue: queue, completionHandler: completionHandler)
	}
}

extension IGDBGame: Identifiable {
	var identifier: String { return "\(id)"}
}

extension IGDBGame: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return SimpleCellViewModel(text: name, detailText: name, identifier: identifier)
	}
}
