//
//  Refreshable.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import Foundation

protocol Refreshable {
	func refreshData(completion: @escaping () -> Void)
}
