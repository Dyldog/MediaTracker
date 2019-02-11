//
//  APIClient.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
	
	private var runningRequests = [URL: DataRequest]()
	
	func makeRequest(_ request: URLRequest, completion: @escaping ((Result<Data>) -> Void)) {
		guard let requestURL = request.url else { return }
		
		if let currentRequest = runningRequests[requestURL] {
			currentRequest.cancel()
			runningRequests.removeValue(forKey: requestURL)
		}
		
		runningRequests[requestURL] = Alamofire.request(request).responseData { response in
			self.runningRequests.removeValue(forKey: requestURL)
			completion(response.result)
		}
	}
}
