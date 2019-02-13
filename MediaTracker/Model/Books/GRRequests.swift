//
//  GoodReadsRequests.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

enum GRRequests {
	private static let baseURL = URL(string: "https://www.goodreads.com")!
	private static let defaultHeaders = ["key": Secrets.GoodReads.key]
	
	private static func searchURL(for query: String) -> URL {
		var url = URLComponents(string: baseURL.appendingPathComponent("search/index.xml").absoluteString)!
		url.queryItems = [
			URLQueryItem(name: "key", value: Secrets.GoodReads.key),
			URLQueryItem(name: "q", value: query)
		]
		url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
		return url.url!
	}
		
	static func search(query: String) -> URLRequest {
		return try! URLRequest(url: searchURL(for: query), method: .get, headers: defaultHeaders)
	}
}
