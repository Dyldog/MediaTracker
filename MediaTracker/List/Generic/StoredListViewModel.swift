//
//  StoredListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class StoredListViewModel<T: Identifiable>: ListViewModel {
	typealias ItemType = T
	
	var cellViewModels: [SimpleCellViewModel]
	
	var mapping: (T) -> SimpleCellViewModel
	
	init(mapping: @escaping (T) -> SimpleCellViewModel) {
		cellViewModels = StorageManager.loadList().map(mapping)
		self.mapping = mapping
	}
	
	func addItem(_ item: T) {
		StorageManager.add(item)
		cellViewModels.append(mapping(item))
	}
	
	func removeItem(at index: Int) {
		let item: T = StorageManager.loadList()[index]
		StorageManager.delete(item)
		cellViewModels.remove(at: index)
	}
}
