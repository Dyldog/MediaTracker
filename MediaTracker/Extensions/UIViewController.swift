//
//  UIViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 27/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

extension UIViewController {
	typealias UIAlertActionHandler = (UIAlertAction) -> Void
	func alert(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style = .alert,
			   okButtonTitle: String = "OK", okHandler: UIAlertActionHandler? = nil,
			   cancelButtonTitle: String = "OK", cancelHandler: UIAlertActionHandler? = nil) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
		alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: okHandler))
		
		if let cancelHandler = cancelHandler {
			alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: cancelHandler))
		}
		
		present(alertController, animated: true, completion: nil)
	}
}
