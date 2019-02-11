//
//  StorageManager.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

protocol Identifiable: Codable, Equatable {
	var identifier: String { get }
}

class StorageManager<T: Identifiable> {

	let namespace: String
	
	init(namespace: String) {
		self.namespace = namespace
	}
	
	private func defaultsKey(forType type: Any.Type) -> String {
		return ["\(namespace)", "\(type.self)"].joined(separator: ".")
	}
	
	func loadList() -> [T] {
		if let data = UserDefaults.standard.data(forKey: defaultsKey(forType: T.self)),
			let list = try? JSONDecoder().decode([T].self, from: data) {
			return list
		}
		
		return []
	}
	
	private func saveList(_ list: [T]) {
		UserDefaults.standard.set(try! JSONEncoder().encode(list), forKey: defaultsKey(forType: T.self))
		UserDefaults.standard.synchronize()
	}
	
	@discardableResult func add(_ item: T, to list: inout [T]) -> [T] {
		list.append(item)
		saveList(list)
		return list
	}
	
	@discardableResult func add(_ item: T) -> [T] {
		var list: [T] = loadList()
		add(item, to: &list)
		return list
	}
	
	@discardableResult func delete(_ item: T, from list: inout [T]) -> [T] {
		list.removeAll(where: { $0.identifier == item.identifier })
		saveList(list)
		return list
	}
	
	@discardableResult func delete(_ item: T) -> [T] {
		var list: [T] = loadList()
		delete(item, from: &list)
		return list
	}
}
