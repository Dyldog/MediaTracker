//
//  LocallyStoredListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class LocallyStoredListViewModel<Model>: MutableListViewModel where Model: SimpleCellViewModelMappable, Model: Identifiable {
	
	typealias ItemType = Model
	var cellViewModels: [SimpleCellViewModel]
	
	var storageManager: StorageManager<Model>
	
	init(namespace: String) {
		storageManager = StorageManager(namespace: namespace)
		cellViewModels = storageManager.loadList().map { $0.asSimpleCellViewModel }
	}
	
	func addItem(_ item: Model) -> MutableListViewModelError? {
		guard cellViewModels.first(where: { $0.identifier == item.identifier }) == nil else { return .alreadyExists }
		
		storageManager.add(item)
		cellViewModels.append(item.asSimpleCellViewModel)
		
		return nil
	}
	
	func removeItem(at index: Int) {
		let item: Model = storageManager.loadList()[index]
		storageManager.delete(item)
		cellViewModels.remove(at: index)
	}
	
	func removeItem(_ item: Model) {
		storageManager.delete(item)
	}
}
