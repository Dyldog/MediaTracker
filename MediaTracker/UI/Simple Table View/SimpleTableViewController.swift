//
//  SimpleTableViewController.swift
//  MediaTracker
//
//  Created by Dylan Elliott on 11/2/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

class SimpleTableViewController: UITableViewController {
	var cellModels: [SimpleCellViewModel] = []
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		cell.detailTextLabel?.numberOfLines = 0
		return cell
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cellModel = cellModels[indexPath.row]
		
		cell.textLabel?.text = cellModel.text
		cell.detailTextLabel?.text = cellModel.detailText
	}
}
