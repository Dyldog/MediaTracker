//
//  RefreshableListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class RefreshableListViewController<Wrapper, Model>: ListViewController<NetworkListViewModel<Void, Wrapper, Model>>
where Wrapper: Codable, Model: Identifiable, Model: SimpleCellViewModelMappable {
	
	init<ViewModel>(viewModel: ViewModel) where ViewModel: NetworkListViewModel<Void, Wrapper, Model> {
		super.init()
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.refreshData {
			self.tableView.reloadData()
		}
	}
}
