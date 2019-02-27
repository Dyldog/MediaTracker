//
//  GRSearchResponse.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let gRSearchResponse = try GRSearchResponse(json)
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

struct GRSearchResponse: Codable, Equatable {
	let goodreadsResponse: GRGoodreadsResponse
	
	enum CodingKeys: String, CodingKey {
		case goodreadsResponse = "GoodreadsResponse"
	}
}

struct GRGoodreadsResponse: Codable, Equatable {
	let request: GRRequest
	let search: GRSearch
	
	enum CodingKeys: String, CodingKey {
		case request = "Request"
		case search = "search"
	}
}

struct GRRequest: Codable, Equatable {
	let authentication: String
	let key: String
	let method: String
	
	enum CodingKeys: String, CodingKey {
		case authentication = "authentication"
		case key = "key"
		case method = "method"
	}
}

struct GRSearch: Codable, Equatable {
	let query: String?
	let resultsStart: String
	let resultsEnd: String
	let totalResults: String
	let source: String
	let queryTimeSeconds: String?
	let results: GRResults?
	
	enum CodingKeys: String, CodingKey {
		case query = "query"
		case resultsStart = "results-start"
		case resultsEnd = "results-end"
		case totalResults = "total-results"
		case source = "source"
		case queryTimeSeconds = "query-time-seconds"
		case results = "results"
	}
}

struct GRResults: Codable, Equatable {
	let work: [GRBook]
	
	enum CodingKeys: String, CodingKey {
		case work = "work"
	}
}

struct GRWork: Codable, Equatable {
	let book: GRBook?
	
	enum CodingKeys: String, CodingKey {
		case book = "book"
	}
}

// MARK: Convenience initializers and mutators

extension GRSearchResponse {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRSearchResponse.self, from: data)
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
		goodreadsResponse: GRGoodreadsResponse? = nil
		) -> GRSearchResponse {
		return GRSearchResponse(
			goodreadsResponse: goodreadsResponse ?? self.goodreadsResponse
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRGoodreadsResponse {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRGoodreadsResponse.self, from: data)
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
		request: GRRequest? = nil,
		search: GRSearch? = nil
		) -> GRGoodreadsResponse {
		return GRGoodreadsResponse(
			request: request ?? self.request,
			search: search ?? self.search
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRRequest {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRRequest.self, from: data)
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
		authentication: String? = nil,
		key: String? = nil,
		method: String? = nil
		) -> GRRequest {
		return GRRequest(
			authentication: authentication ?? self.authentication,
			key: key ?? self.key,
			method: method ?? self.method
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRSearch {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRSearch.self, from: data)
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
		query: String? = nil,
		resultsStart: String? = nil,
		resultsEnd: String? = nil,
		totalResults: String? = nil,
		source: String? = nil,
		queryTimeSeconds: String? = nil,
		results: GRResults? = nil
		) -> GRSearch {
		return GRSearch(
			query: query ?? self.query,
			resultsStart: resultsStart ?? self.resultsStart,
			resultsEnd: resultsEnd ?? self.resultsEnd,
			totalResults: totalResults ?? self.totalResults,
			source: source ?? self.source,
			queryTimeSeconds: queryTimeSeconds ?? self.queryTimeSeconds,
			results: results ?? self.results
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRResults {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRResults.self, from: data)
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
		work: [GRBook]? = nil
		) -> GRResults {
		return GRResults(
			work: work ?? self.work
		)
	}
	
	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}
	
	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

extension GRWork {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(GRWork.self, from: data)
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
		book: GRBook? = nil
		) -> GRWork {
		return GRWork(
			book: book ?? self.book
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
