//
//  IGDBRequests.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

enum IGDBRequests {
	private static let baseURL = URL(string: "https://api-v3.igdb.com")!
	private static let defaultHeaders = ["user-key": Secrets.igdbAPIKey]
	private static let gamesURL: URL = baseURL.appendingPathComponent("games")
	
	static func search(query: String) -> URLRequest {
		var request = try! URLRequest(url: gamesURL, method: .post, headers: defaultHeaders)
		let bodyString = "fields *; search \"\(query)\"; where version_parent = null;"
		request.httpBody = bodyString.data(using: .utf8)!
		return request
	}
}
