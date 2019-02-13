//
//  AppDelegate.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 10/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let userListNamespaceKey = "USER_LIST"
		
		let gamesListViewController = StoredListViewController<IGDBGame>(namespace: userListNamespaceKey, searchRequestFactory: IGDBRequests.search)
		gamesListViewController.title = "Games"
		
		let booksSearchViewModel = MappingAPISearchViewModel<GRGoodreadsResponse, GRBook>(searchResultMapping: { (wrapper: GRGoodreadsResponse) in
			wrapper.search.results?.work.compactMap { $0 } ?? []
		}, searchRequestFactory: GRRequests.search)
		
		let booksListViewController = StoredListViewController<GRBook>(
			searchViewModel: booksSearchViewModel,
			namespace: userListNamespaceKey)
		booksListViewController.title = "Books"
		
		func tmdbListViewController<T>(_ title: String, _ searchRequest: (@escaping (String) -> URLRequest)) -> StoredListViewController<T> {
			let tmdbSearchViewModel = MappingAPISearchViewModel<TMDBSearchResponse, T>(searchResultMapping: { $0.results }, searchRequestFactory: searchRequest)
			let tmdbListViewController = StoredListViewController<T>(searchViewModel: tmdbSearchViewModel, namespace: "\(userListNamespaceKey)_\(title)")
			tmdbListViewController.title = title
			return tmdbListViewController
		}
		
		let moviesListViewController: StoredListViewController<TMDBMovie> = tmdbListViewController("Movies", TMDBRequests.searchMovies)
		let tvShowListViewController: StoredListViewController<TMDBTVShow> = tmdbListViewController("TV", TMDBRequests.searchTV)
		
		self.window = UIWindow(rootViewController: [
			gamesListViewController.inNavigationController,
			booksListViewController.inNavigationController,
			moviesListViewController.inNavigationController,
			tvShowListViewController.inNavigationController
		].inTabBarController)
		
		return true
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
