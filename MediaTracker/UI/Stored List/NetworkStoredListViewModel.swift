//
//  NetworkStoredListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

class NetworkStoredListViewModel<Wrapper, Model: Identifiable & SimpleCellViewModelMappable>: MappingNetworkListViewModel<Void, Wrapper, Model>, MutableListViewModel where Wrapper: Codable {	
	
	typealias ItemType = Model
	
	func addItem(_ item: Model) {}
	
	func removeItem(at index: Int) {}
	
	func removeItem(_ item: Model) {}
}
