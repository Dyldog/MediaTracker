//
//  SWAPIPerson.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

struct SWAPIPerson: Codable, Equatable {
	let name: String
	let height: String
	let mass: String
	let hairColor: String
	let skinColor: String
	let eyeColor: String
	let birthYear: String
	let gender: SWAPIGender
	let homeworld: String
	let films: [String]
	let species: [String]
	let vehicles: [String]
	let starships: [String]
	let created: String
	let edited: String
	let url: String
	
	enum CodingKeys: String, CodingKey {
		case name = "name"
		case height = "height"
		case mass = "mass"
		case hairColor = "hair_color"
		case skinColor = "skin_color"
		case eyeColor = "eye_color"
		case birthYear = "birth_year"
		case gender = "gender"
		case homeworld = "homeworld"
		case films = "films"
		case species = "species"
		case vehicles = "vehicles"
		case starships = "starships"
		case created = "created"
		case edited = "edited"
		case url = "url"
	}
}

enum SWAPIGender: String, Codable, Equatable {
	case female = "female"
	case male = "male"
	case nA = "n/a"
}

extension SWAPIPerson: Identifiable {
	var identifier: String { return url }
}

extension SWAPIPerson: SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel {
		return SimpleCellViewModel(imageURL: nil, text: name, detailText: homeworld, identifier: identifier)
	}
}
