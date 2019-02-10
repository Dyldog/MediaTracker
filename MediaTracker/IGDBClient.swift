//
//  API.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire
//
//enum Result<T> {
//	case success(T)
//	case failure
//}

enum IGDBClientError: Error {
	case generalError
}

struct IGDBClient {
	private static let baseURL = URL(string: "https://api-v3.igdb.com")!
	private static let defaultHeaders = ["user-key": Secrets.igdbAPIKey]
	private static let gamesURL: URL = baseURL.appendingPathComponent("games")
	
	private var runningRequests = [URL: DataRequest]()
	
	mutating func search(query: String, completion: @escaping (Result<[IGDBGame]>) -> ()) {
		if let currentRequest = runningRequests[IGDBClient.gamesURL] {
			currentRequest.cancel()
			runningRequests.removeValue(forKey: IGDBClient.gamesURL)
		}
		
		var request = try! URLRequest(url: IGDBClient.gamesURL, method: .post, headers: IGDBClient.defaultHeaders)
		let bodyString = "fields *; search \"\(query)\"; where version_parent = null;"
		request.httpBody = bodyString.data(using: .utf8)!
		
		runningRequests[IGDBClient.gamesURL] = Alamofire.request(request).responseData { response in
			switch response.result {
			case .success(let gameData):
				let searchResults = (try? JSONDecoder().decode([IGDBGame].self, from: gameData)) ?? []
				completion(.success(searchResults.sorted(by: { $0.firstReleaseDate > $1.firstReleaseDate })))
				
			case .failure(_):
				completion(.failure(IGDBClientError.generalError))
			}
		}
	}
}
