//
//  ListViewModel.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

protocol ListViewModel {
	associatedtype ItemType
	
	var cellViewModels: [SimpleCellViewModel] { get }
}
