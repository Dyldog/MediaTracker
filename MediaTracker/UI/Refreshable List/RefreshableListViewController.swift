//
//  RefreshableListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 17/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class RefreshableListViewController<Model>: ListViewController<NetworkListViewModel<Void, Model>>
where Model: Identifiable, Model: SimpleCellViewModelMappable {
	
	init<ViewModel>(viewModel: ViewModel) where ViewModel: NetworkListViewModel<Void, Model> {
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
