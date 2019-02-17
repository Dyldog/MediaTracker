//
//  TraktShowe.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation


struct TraktShow: Codable, Equatable {
	let title: String
	let year: Int
	let ids: TraktIDS
	
	enum CodingKeys: String, CodingKey {
		case title = "title"
		case year = "year"
		case ids = "ids"
	}
}

extension TraktShow: Identifiable {
	var identifier: String { return "\(ids.trakt)" }
}

extension TraktShow: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return SimpleCellViewModel(text: title, detailText: "\(year)", identifier: identifier)
	}
}
