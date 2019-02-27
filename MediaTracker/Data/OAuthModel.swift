//
//  OAuthDetails.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

struct OAuthModel {
	let authURL: URL
	let tokenURL: URL
	let clientID: String
	
	init(baseURL: String, authEndpoint: String, tokenEndpoint: String, clientID: String) {
		let base = URL(string: baseURL)!
		authURL = base.appendingPathComponent(authEndpoint)
		tokenURL = base.appendingPathComponent(tokenEndpoint)
		self.clientID = clientID
	}
}
