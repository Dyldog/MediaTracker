//
//  SimpleCellViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

struct SimpleCellViewModel {
	var text: String
	var detailText: String
	var identifier: String
}

protocol SimpleCellViewModelMappable {
	var title: String { get }
	var subtitle: String { get }
	var identifier: String { get }
	
	var asSimpleCellViewModel: SimpleCellViewModel { get }
}

extension SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return SimpleCellViewModel(text: title, detailText: subtitle, identifier: identifier)
	}
}
