//
//  TMDBRequests.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 13/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

enum TMDBRequests {
	enum SearchType: String {
		case movies = "movie"
		case tv = "tv"
	}
	
	private static let baseURL = URL(string: "https://api.themoviedb.org/3")!
	private static let defaultHeaders = ["key": Secrets.GoodReads.key]
	
	private static func searchURL(for query: String, ofType type: SearchType) -> URL {
		var url = URLComponents(string: baseURL.appendingPathComponent("/search/\(type.rawValue)").absoluteString)!
		url.queryItems = [
			URLQueryItem(name: "api_key", value: Secrets.TheMovieDB.key),
			URLQueryItem(name: "query", value: query)
		]
		url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
		return url.url!
	}
	
	static func search(query: String) -> (SearchType) -> URLRequest {
		return { searchType in try! URLRequest(url: searchURL(for: query, ofType: searchType), method: .get, headers: defaultHeaders) }
	}
	
	static func searchMovies(query: String) -> URLRequest {
		return search(query: query)(.movies)
	}
	
	static func searchTV(query: String) -> URLRequest {
		return search(query: query)(.tv)
	}
}
