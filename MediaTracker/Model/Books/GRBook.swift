//
//  GRBook.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let gRBook = try GRBook(json)
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

struct GRBook: Codable, Equatable {
	let booksCount: Int
//	let originalPublicationMonth: Int?
	let textReviewsCount: Int
//	let originalPublicationYear: Int
//	let originalPublicationDay: Int?
	let bestBook: GRBestBook
	let ratingsCount: Int
	let id: Int
	let averageRating: String
	
	enum CodingKeys: String, CodingKey {
		case booksCount = "books_count"
//		case originalPublicationMonth = "original_publication_month"
		case textReviewsCount = "text_reviews_count"
//		case originalPublicationYear = "original_publication_year"
//		case originalPublicationDay = "original_publication_day"
		case bestBook = "best_book"
		case ratingsCount = "ratings_count"
		case id = "id"
		case averageRating = "average_rating"
	}
}

struct GRBestBook: Codable, Equatable {
	let author: GRAuthor
	let title: String
	let imageURL: String
	let smallImageURL: String
	let id: Int
	
	enum CodingKeys: String, CodingKey {
		case author = "author"
		case title = "title"
		case imageURL = "image_url"
		case smallImageURL = "small_image_url"
		case id = "id"
	}
}

struct GRAuthor: Codable, Equatable {
	let id: Int
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
	}
}

// MARK: Convenience initializers and mutators

extension GRBook {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRBook.self, from: data)
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
	
	func with(
		booksCount: Int? = nil,
		originalPublicationMonth: Int? = nil,
		textReviewsCount: Int? = nil,
		originalPublicationYear: Int? = nil,
		originalPublicationDay: Int? = nil,
		bestBook: GRBestBook? = nil,
		ratingsCount: Int? = nil,
		id: Int? = nil,
		averageRating: String? = nil
		) -> GRBook {
		return GRBook(
			booksCount: booksCount ?? self.booksCount,
//			originalPublicationMonth: originalPublicationMonth ?? self.originalPublicationMonth,
			textReviewsCount: textReviewsCount ?? self.textReviewsCount,
//			originalPublicationYear: originalPublicationYear ?? self.originalPublicationYear,
//			originalPublicationDay: originalPublicationDay ?? self.originalPublicationDay,
			bestBook: bestBook ?? self.bestBook,
			ratingsCount: ratingsCount ?? self.ratingsCount,
			id: id ?? self.id,
			averageRating: averageRating ?? self.averageRating
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRBestBook {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRBestBook.self, from: data)
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
	
	func with(
		author: GRAuthor? = nil,
		title: String? = nil,
		imageURL: String? = nil,
		smallImageURL: String? = nil,
		id: Int? = nil
		) -> GRBestBook {
		return GRBestBook(
			author: author ?? self.author,
			title: title ?? self.title,
			imageURL: imageURL ?? self.imageURL,
			smallImageURL: smallImageURL ?? self.smallImageURL,
			id: id ?? self.id
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRAuthor {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRAuthor.self, from: data)
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
	
	func with(
		id: Int? = nil,
		name: String? = nil
		) -> GRAuthor {
		return GRAuthor(
			id: id ?? self.id,
			name: name ?? self.name
		)
	}
	
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

extension GRBook: Identifiable {
	var identifier: String {
		return "\(self.id)"
	}
}

extension GRBook: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return SimpleCellViewModel(imageURL: nil, text: bestBook.title, detailText: bestBook.author.name, identifier: identifier)
	}
}
