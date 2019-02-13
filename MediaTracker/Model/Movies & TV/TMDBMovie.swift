//
//  TMDBMovie.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 13/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

struct TMDBMovie: Codable, Equatable {
	let voteCount: Int?
	let id: Int
	let video: Bool?
	let voteAverage: Double?
	let title: String?
	let popularity: Double?
	let posterPath: String?
	let originalLanguage: String?
	let originalTitle: String?
	let genreIDS: [Int]?
	let backdropPath: String?
	let adult: Bool?
	let overview: String?
	let releaseDate: String?
	
	enum CodingKeys: String, CodingKey {
		case voteCount = "vote_count"
		case id = "id"
		case video = "video"
		case voteAverage = "vote_average"
		case title = "title"
		case popularity = "popularity"
		case posterPath = "poster_path"
		case originalLanguage = "original_language"
		case originalTitle = "original_title"
		case genreIDS = "genre_ids"
		case backdropPath = "backdrop_path"
		case adult = "adult"
		case overview = "overview"
		case releaseDate = "release_date"
	}
}

extension TMDBMovie: Identifiable {
	var identifier: String { return "\(id)" }
}

extension TMDBMovie: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return .init(text: title ?? "", detailText: overview ?? "", identifier: identifier)
	}
}
