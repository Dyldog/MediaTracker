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
		
		let gamesListViewController = StoredListViewController<IGDBGame>(namespace: "USER_LIST", searchRequestFactory: IGDBRequests.search)
		gamesListViewController.title = "Games"
		
		let booksSearchViewModel = MappingAPISearchViewModel<GRGoodreadsResponse, GRBook>(searchResultMapping: { (wrapper: GRGoodreadsResponse) in
			wrapper.search.results?.work.compactMap { $0 } ?? []
		}, cellViewModelMapping: {
			$0.asSimpleCellViewModel
		}, searchRequestFactory: GRRequests.search)
		
		let booksListViewController = StoredListViewController<GRBook>(
			searchViewModel: booksSearchViewModel,
			namespace: "USER_LIST", searchRequestFactory: GRRequests.search)
		booksListViewController.title = "Books"
		
		self.window = UIWindow(rootViewController: [
			gamesListViewController.inNavigationController,
			booksListViewController.inNavigationController
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
