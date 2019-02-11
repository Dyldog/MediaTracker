//
//  SearchViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

protocol SearchViewModel {
	associatedtype ResultType
	
	var searchResults: [ResultType] { get }
	func updateSearchResults(for searchText: String, completion: @escaping () -> Void)
	
	var cellViewModels: [SearchCellViewModel] { get }
}

typealias SearchCellViewModel = SimpleCellViewModel
