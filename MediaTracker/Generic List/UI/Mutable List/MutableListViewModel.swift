//
//  MutableListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

enum MutableListViewModelError: Error {
	case alreadyExists
}

protocol MutableListViewModel: ListViewModel {
	
	func addItem(_ item: ItemType) -> MutableListViewModelError?
	func removeItem(at index: Int)
	func removeItem(_ item: ItemType)
}
