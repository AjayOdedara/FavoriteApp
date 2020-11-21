//
//  EventsViewController.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 20/11/20.
//

import UIKit

class EventsViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	// MARK: - View Setup
	private func configureUI() {
		
		self.title = EventViewConstants.View.navigationTitle
		
		tableView.tableFooterView = UIView()
		tableView.estimatedRowHeight = 150
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

		tableView.register(UINib(nibName: EventViewConstants.CellIdentifier.tableViewEvents,
														 bundle: nil),
											 forCellReuseIdentifier: EventViewConstants.CellIdentifier.tableViewEvents)
	}
}

