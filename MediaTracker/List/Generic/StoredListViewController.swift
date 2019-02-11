//
//  GameListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

protocol SimpleCellViewModelMappable {
	var asSimpleCellViewModel: SimpleCellViewModel { get }
}

class StoredListViewController<Model>: ListViewController<StoredListViewModel<Model>, APISearchViewModel<Model>> where Model: Identifiable, Model: SimpleCellViewModelMappable {
	
	init(namespace: String, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		super.init()
		
		searchViewModel = APISearchViewModel(searchRequestFactory: searchRequestFactory)
		
		viewModel = StoredListViewModel(namespace: namespace, mapping: { (model: Model) in
			return model.asSimpleCellViewModel
		})
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
