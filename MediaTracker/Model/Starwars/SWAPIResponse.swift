//
//  SWAPIResponse.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let sWAPIResponse = try? newJSONDecoder().decode(SWAPIResponse.self, from: jsonData)
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

struct SWAPIResponse: Codable, Equatable {
	let count: Int
	let next: String
	let previous: JSONNull?
	let results: [SWAPIPerson]
	
	enum CodingKeys: String, CodingKey {
		case count = "count"
		case next = "next"
		case previous = "previous"
		case results = "results"
	}
}



// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
	
	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}
	
	public var hashValue: Int {
		return 0
	}
	
	public init() {}
	
	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}
