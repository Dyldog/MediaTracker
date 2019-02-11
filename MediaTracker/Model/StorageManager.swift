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

class StorageManager {

	private static func defaultsKey(forType type: Any.Type) -> String {
		return "\(type.self)"
	}
	
	static func loadList<T>() -> [T] where T: Codable {
		if let data = UserDefaults.standard.data(forKey: defaultsKey(forType: T.self)),
			let list = try? JSONDecoder().decode([T].self, from: data) {
			return list
		}
		
		return []
	}
	
	private static func saveList<T>(_ list: [T]) where T: Codable {
		UserDefaults.standard.set(try! JSONEncoder().encode(list), forKey: "\(T.self)")
	}
	
	@discardableResult static func add<T: Codable>(_ item: T, to list: inout [T]) -> [T] {
		list.append(item)
		saveList(list)
		return list
	}
	
	@discardableResult static func add<T: Codable>(_ item: T) -> [T] {
		var list: [T] = loadList()
		add(item, to: &list)
		return list
	}
	
	@discardableResult static func delete<T: Identifiable>(_ item: T, from list: inout [T]) -> [T] {
		list.removeAll(where: { $0.identifier == item.identifier })
		saveList(list)
		return list
	}
	
	@discardableResult static func delete<T: Identifiable>(_ item: T) -> [T] {
		var list: [T] = loadList()
		delete(item, from: &list)
		return list
	}
}
