//
//  AppDelegate.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit
import Iconic

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let userListNamespaceKey = "USER_LIST"

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		FontAwesomeIcon.register()
		
		self.window = UIWindow(rootViewController: [
//			swapiPeopleListViewController.inNavigationController,
			gamesViewController.inNavigationController,
			booksViewController.inNavigationController,
			moviesListViewController.inNavigationController,
			tvShowListViewController.inNavigationController
		].inTabBarController)
		
		return true
	}
}

extension AppDelegate {
	var gamesViewController: StoredAPIListViewController<LocallyStoredListViewModel<IGDBGame>> {
		let gamesListViewController = StoredAPIListViewController<LocallyStoredListViewModel<IGDBGame>>(
			viewModel: locallyStoredListViewModel(),
			namespace: userListNamespaceKey,
			searchRequestFactory: IGDBRequests.search)
		gamesListViewController.title = "Games"
		gamesListViewController.tabBarItem.image = Iconic.image(withIcon: .gamepadIcon, size: CGSize(width: 40, height: 30), color: .black)
		return gamesListViewController
	}
	
	var booksViewController: StoredAPIListViewController<LocallyStoredListViewModel<GRBook>> {
		let booksSearchViewModel = MappingAPISearchViewModel<GRGoodreadsResponse, GRBook>(resultMapping: { (wrapper: GRGoodreadsResponse) in
			wrapper.search.results?.work.compactMap { $0 } ?? []
		}, searchRequestFactory: GRRequests.search)
		
		let booksListViewController = StoredAPIListViewController<LocallyStoredListViewModel<GRBook>>(
			viewModel: locallyStoredListViewModel(),
			searchViewModel: booksSearchViewModel,
			namespace: userListNamespaceKey)
		booksListViewController.title = "Books"
		booksListViewController.tabBarItem.image = Iconic.image(withIcon: .bookIcon, size: CGSize(width: 40, height: 30), color: .black)
		
		return booksListViewController
	}
	
	private func tmdbListViewController<Model> (_ title: String, _ icon: FontAwesomeIcon, _ searchRequest: (@escaping (String) -> URLRequest)) -> StoredAPIListViewController<LocallyStoredListViewModel<Model>> where Model: Identifiable, Model: SimpleCellViewModelMappable {
		let tmdbListViewModel: LocallyStoredListViewModel<Model> = locallyStoredListViewModel()
		let tmdbSearchViewModel: MappingAPISearchViewModel<TMDBSearchResponse, Model> = MappingAPISearchViewModel<TMDBSearchResponse, Model>(resultMapping: { $0.results }, searchRequestFactory: searchRequest)
		
		let tmdbListViewController: StoredAPIListViewController<LocallyStoredListViewModel<Model>> = StoredAPIListViewController<LocallyStoredListViewModel<Model>>(
			viewModel: tmdbListViewModel,
			searchViewModel: tmdbSearchViewModel,
			namespace: "\(userListNamespaceKey)_\(title)"
		)
		
		tmdbListViewController.title = title
		tmdbListViewController.tabBarItem.image = Iconic.image(withIcon: icon, size: CGSize(width: 40, height: 30), color: .black)
		return tmdbListViewController
	}
	
	var moviesListViewController: StoredAPIListViewController<LocallyStoredListViewModel<TMDBMovie>>  {
		return tmdbListViewController("Movies", .filmIcon, TMDBRequests.searchMovies)
	}
	
	var tvShowListViewController: StoredAPIListViewController<LocallyStoredListViewModel<TMDBTVShow>> {
		return tmdbListViewController("TV", .desktopIcon, TMDBRequests.searchTV)
	}
	
//	var articleListViewController: RefreshableListViewController<NetworkStoredListViewModel<IPArticle>> {
//		let articleViewController = RefreshableListViewController(viewModel: NetworkStoredListViewModel<IPArticle>())
//		articleViewController.title = "Articles"
//		articleViewController.tabBarItem.image = Iconic.image(withIcon: .paperClipIcon, size: CGSize(width: 40, height: 30), color: .black)
//		return articleViewController
//	}
	
	var swapiPeopleListViewController: RefreshableListViewController<SWAPIPerson> {
		let swapiList = RefreshableListViewController<SWAPIPerson>(
			viewModel: MappingNetworkListViewModel<Void, SWAPIResponse, SWAPIPerson>(
				resultMapping: { $0.results },
				searchRequestFactory: SWAPIRequests.people))
		swapiList.title = "Star Wars"
		swapiList.tabBarItem.image = Iconic.image(withIcon: .starIcon, size: CGSize(width: 40, height: 30), color: .black)
		return swapiList
	}
	
}

extension AppDelegate {
	func locallyStoredListViewModel<T: SimpleCellViewModelMappable>() -> LocallyStoredListViewModel<T> {
		return LocallyStoredListViewModel<T>(
			namespace: userListNamespaceKey,
			mapping: { $0.asSimpleCellViewModel }
		)
	}
}

extension UIWindow {
	convenience init(rootViewController: UIViewController, frame: CGRect = UIScreen.main.bounds, makeKey: Bool = true) {
		self.init(frame: frame)
		self.rootViewController = rootViewController
		if makeKey { self.makeKeyAndVisible() }
	}
}

extension UIViewController {
	var inNavigationController: UINavigationController {
		return UINavigationController(rootViewController: self)
	}
}

extension Array where Element: UIViewController {
	var inTabBarController: UITabBarController {
		let tc = UITabBarController()
		tc.viewControllers = self
		return tc
	}
}
