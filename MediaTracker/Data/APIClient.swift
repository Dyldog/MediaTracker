//
//  APIClient.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation
import Alamofire
import XMLParsing

enum APIClientError: Error {
	case decodingFailed(decodingError: Error)
	case unknownResponseContentType
}

class APIClient {
	
	private var runningRequests = [String: DataRequest]()
	
	private func cacheKey(for url: URL) -> String {
		return "\(url.host ?? "")/\(url.path)"
	}
	private func makeRequest(_ request: URLRequest, completion: @escaping ((DataResponse<Data>) -> Void)) {
		guard let requestURL = request.url else { return }
		
		if let currentRequest = runningRequests[cacheKey(for: requestURL)] {
			currentRequest.cancel()
			runningRequests.removeValue(forKey: cacheKey(for: requestURL))
		}
		
		runningRequests[cacheKey(for: requestURL)] = Alamofire.request(request).responseData { response in
			self.runningRequests.removeValue(forKey: self.cacheKey(for: requestURL))
			completion(response)
		}
	}
	
	func makeRequest(_ request: URLRequest, completion: @escaping ((Result<Data>) -> Void)) {
		makeRequest(request) { response in
			completion(response.result)
		}
	}
	
	func makeRequest<T: Codable>(_ request: URLRequest, completion: @escaping ((Result<T>) -> Void)) {
		makeRequest(request) { (response: DataResponse<Data>) in
			switch response.result {
			case .success(let data):
				let headers = response.response!.allHeaderFields
				let contentTypeString = headers["Content-Type"] as! String
				let contentType = contentTypeString.components(separatedBy: ";")[0]
				
				let decodingResult: Result<T> = {
					switch contentType {
					case "application/json": return self.decodeJSON(from: data)
					case "application/xml": return self.decodeXML(from: data)
					default: return .failure(APIClientError.unknownResponseContentType)
					}
				}()
				
				switch decodingResult {
				case .success(let decodedObj):
					completion(.success(decodedObj))
				case .failure(let error):
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	private func handleDecodeError(error: Error, for data: Data) {
		print("API CLIENT ERROR: Could not decode object")
		print("Description: \(error.localizedDescription)")
		print("Response: \(String(data: data, encoding: .utf8) ?? "COULDNT DECODE STRING")")
	}
	
	private func decodeJSON<T: Codable>(from data: Data) -> Result<T> {
		do {
			let obj = try JSONDecoder().decode(T.self, from: data)
			return .success(obj)
		} catch {
			handleDecodeError(error: error, for: data)
			return .failure(APIClientError.decodingFailed(decodingError: error))
		}
	}
	
	private func decodeXML<T: Codable>(from data: Data) -> Result<T> {
		do {
			let xmlString = String(data: data, encoding: .utf8)!
			let fixedXMLString = xmlString.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", with: "").replacingOccurrences(of: "\n", with: "")
			let obj = try XMLDecoder().decode(T.self, from: fixedXMLString.data(using: .utf8)!)
			return .success(obj)
		} catch {
			handleDecodeError(error: error, for: data)
			return .failure(APIClientError.decodingFailed(decodingError: error))
		}
	}
}
