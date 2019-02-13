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
			gamesViewController.inNavigationController,
			booksViewController.inNavigationController,
			moviesListViewController.inNavigationController,
			tvShowListViewController.inNavigationController
		].inTabBarController)
		
		return true
	}
}

extension AppDelegate {
	var gamesViewController: StoredListViewController<IGDBGame> {
		let gamesListViewController = StoredListViewController<IGDBGame>(namespace: userListNamespaceKey, searchRequestFactory: IGDBRequests.search)
		gamesListViewController.title = "Games"
		gamesListViewController.tabBarItem.image = Iconic.image(withIcon: .gamepadIcon, size: CGSize(width: 40, height: 30), color: .black)
		return gamesListViewController
	}
	
	var booksViewController: StoredListViewController<GRBook> {
		let booksSearchViewModel = MappingAPISearchViewModel<GRGoodreadsResponse, GRBook>(searchResultMapping: { (wrapper: GRGoodreadsResponse) in
			wrapper.search.results?.work.compactMap { $0 } ?? []
		}, searchRequestFactory: GRRequests.search)
		
		let booksListViewController = StoredListViewController<GRBook>(
			searchViewModel: booksSearchViewModel,
			namespace: userListNamespaceKey)
		booksListViewController.title = "Books"
		booksListViewController.tabBarItem.image = Iconic.image(withIcon: .bookIcon, size: CGSize(width: 40, height: 30), color: .black)
		
		return booksListViewController
	}
	
	private func tmdbListViewController<T>(_ title: String, _ icon: FontAwesomeIcon, _ searchRequest: (@escaping (String) -> URLRequest)) -> StoredListViewController<T> {
		let tmdbSearchViewModel = MappingAPISearchViewModel<TMDBSearchResponse, T>(searchResultMapping: { $0.results }, searchRequestFactory: searchRequest)
		let tmdbListViewController = StoredListViewController<T>(searchViewModel: tmdbSearchViewModel, namespace: "\(userListNamespaceKey)_\(title)")
		tmdbListViewController.title = title
		tmdbListViewController.tabBarItem.image = Iconic.image(withIcon: icon, size: CGSize(width: 40, height: 30), color: .black)
		return tmdbListViewController
	}
	
	var moviesListViewController: StoredListViewController<TMDBMovie> {
		return tmdbListViewController("Movies", .filmIcon, TMDBRequests.searchMovies)
	}
	
	var tvShowListViewController: StoredListViewController<TMDBTVShow> {
		return tmdbListViewController("TV", .desktopIcon, TMDBRequests.searchTV)
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
