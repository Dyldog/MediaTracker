//
//  TraktRequests.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

//
//  TMDBRequests.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 13/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

enum TraktRequests {
	enum SearchType: String {
		case movies = "movies"
		case tv = "shows"
	}
	
	private static let baseURL = URL(string: "https://api.trakt.tv")!
	private static let defaultHeaders: [String: String] = [
		"Content-Type": "application/json",
		"trakt-api-version": "2",
		"trakt-api-key": Secrets.Trakt.clientID
	]
	
//	private static func searchURL(for query: String, ofType type: SearchType) -> URL {
//		var url = URLComponents(string: baseURL.appendingPathComponent("/search/\(type.rawValue)").absoluteString)!
//		url.queryItems = [
//			URLQueryItem(name: "api_key", value: Secrets.TheMovieDB.key),
//			URLQueryItem(name: "query", value: query)
//		]
//		url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
//		return url.url!
//	}
//	
//	static func search(query: String) -> (SearchType) -> URLRequest {
//		return { searchType in try! URLRequest(url: searchURL(for: query, ofType: searchType), method: .get, headers: defaultHeaders) }
//	}
//	
//	static func searchMovies(query: String) -> URLRequest {
//		return search(query: query)(.movies)
//	}
//	
//	static func searchTV(query: String) -> URLRequest {
//		return search(query: query)(.tv)
//	}
	
	static func listURL(ofType: SearchType) -> URL {		
		var url = URLComponents(string: baseURL.appendingPathComponent("/users/\(Secrets.Trakt.username)/watchlist/\(ofType.rawValue)").absoluteString)!
		
		url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
		return url.url!
	}
	
	static func list(ofType: SearchType) -> URLRequest {
		return try! URLRequest(url: listURL(ofType: ofType), method: .get, headers: defaultHeaders)
	}
}
