//
//  TraktResponse.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let traktResponse = try? newJSONDecoder().decode(TraktResponse.self, from: jsonData)
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

typealias TraktResponse = [TraktResponseElement]

struct TraktResponseElement: Codable, Equatable {
	let rank: Int
	let listedAt: String
	let type: String
	let movie: TraktMovie?
	let show: TraktShow?
	
	enum CodingKeys: String, CodingKey {
		case rank = "rank"
		case listedAt = "listed_at"
		case type = "type"
		case movie = "movie"
		case show = "show"
	}
}

extension TraktResponseElement {
	func value<T>() -> T {
		switch T.self {
		case is TraktMovie.Type: return movie! as! T
		case is TraktShow.Type: return show! as! T
		default: fatalError()
		}
	}
}

