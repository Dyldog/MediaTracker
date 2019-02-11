//
//  StoredListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class StoredListViewModel<Model: Identifiable>: ListViewModel {
	
	typealias ItemType = Model
	var mapping: (Model) -> SimpleCellViewModel
	var cellViewModels: [SimpleCellViewModel]
	
	var storageManager: StorageManager<Model>
	
	init(namespace: String, mapping: @escaping (Model) -> SimpleCellViewModel) {
		storageManager = StorageManager(namespace: namespace)
		cellViewModels = storageManager.loadList().map(mapping)
		self.mapping = mapping
	}
	
	func addItem(_ item: Model) {
		storageManager.add(item)
		cellViewModels.append(mapping(item))
	}
	
	func removeItem(at index: Int) {
		let item: Model = storageManager.loadList()[index]
		storageManager.delete(item)
		cellViewModels.remove(at: index)
	}
}
