//
//  GameListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class StoredListViewController<Model>: ListViewController<StoredListViewModel<Model>, APISearchViewModel<Model>> where Model: Identifiable, Model: SimpleCellViewModelMappable {
	
	init(viewModel: StoredListViewModel<Model>? = nil, searchViewModel: APISearchViewModel<Model>, namespace: String) {
		super.init()
		
		self.searchViewModel = searchViewModel
		
		self.viewModel = viewModel ?? StoredListViewModel(namespace: namespace) { $0.asSimpleCellViewModel }
	}
	
	init(viewModel: StoredListViewModel<Model>? = nil, namespace: String, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		super.init()
		
		self.searchViewModel = APISearchViewModel(cellViewModelMapping: { $0.asSimpleCellViewModel }, searchRequestFactory: searchRequestFactory)
		
		self.viewModel = viewModel ?? StoredListViewModel(namespace: namespace) { $0.asSimpleCellViewModel }
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			viewModel.removeItem(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
