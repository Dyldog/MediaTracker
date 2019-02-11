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
	
	init(title: String? = nil, searchRequestFactory: @escaping ((String) -> URLRequest)) {
		super.init()
		
		searchViewModel = APISearchViewModel(searchRequestFactory: searchRequestFactory)
		
		viewModel = StoredListViewModel(mapping: { (model: Model) in
			return model.asSimpleCellViewModel
		})
		
		self.title = title
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
