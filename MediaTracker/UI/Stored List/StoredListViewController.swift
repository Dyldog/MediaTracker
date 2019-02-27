//
//  GameListViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class StoredAPIListViewController<StoredListVM, ResponseWrapper>: MutableListViewController<StoredListVM, NetworkListViewModel<String, ResponseWrapper, StoredListVM.ItemType>> where StoredListVM: MutableListViewModel, StoredListVM.ItemType: Identifiable, StoredListVM.ItemType: SimpleCellViewModelMappable, ResponseWrapper: Codable {
	
	init(viewModel: StoredListVM, searchViewModel: NetworkListViewModel<String, ResponseWrapper, StoredListVM.ItemType>, namespace: String) {
		super.init(viewModel: viewModel, searchViewModel: searchViewModel)
			// ?? StoredListViewModel(namespace: namespace) { $0.asSimpleCellViewModel }
	}
	
	init(viewModel: StoredListVM, namespace: String, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		super.init(
			viewModel: viewModel,
			searchViewModel: APISearchViewModel(requestFactory: searchRequestFactory)
		)
			// ?? StoredListViewModel(namespace: namespace) { $0.asSimpleCellViewModel }
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
