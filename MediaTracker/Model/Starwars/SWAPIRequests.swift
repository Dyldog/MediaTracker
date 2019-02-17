//
//  SWAPIRequests.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

enum SWAPIRequests {
	private static var baseURL = URL(string: "https://swapi.co/api/")!
	private static var peopleURL = baseURL.appendingPathComponent("people")
	
	static func people() -> URLRequest {
		return try! URLRequest(url: peopleURL, method: .get)
	}
}
