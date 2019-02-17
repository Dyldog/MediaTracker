//
//  TraktMovie.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

struct TraktMovie: Codable, Equatable {
	let title: String
	let year: Int
	let ids: TraktIDS
	
	enum CodingKeys: String, CodingKey {
		case title = "title"
		case year = "year"
		case ids = "ids"
	}
}

struct TraktIDS: Codable, Equatable {
	let trakt: Int
	let slug: String
	let imdb: String?
	let tmdb: Int?
	
	enum CodingKeys: String, CodingKey {
		case trakt = "trakt"
		case slug = "slug"
		case imdb = "imdb"
		case tmdb = "tmdb"
	}
}

extension TraktMovie: Identifiable {
	var identifier: String { return "\(ids.trakt)" }
}

extension TraktMovie: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return SimpleCellViewModel(text: title, detailText: "\(year)", identifier: identifier)
	}
}
