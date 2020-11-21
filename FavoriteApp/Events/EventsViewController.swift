//
//  EventsViewController.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 20/11/20.
//

import UIKit

class EventsViewController: UITableViewController {

	lazy var viewModel: EventViewModel = {
		return EventViewModel()
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		bindViewModel()
	}
	
	// MARK: - View Setup
	private func configureUI() {
		
		self.title = EventViewConstants.View.navigationTitle
		
		tableView.tableFooterView = UIView()
		tableView.estimatedRowHeight = 150
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
		tableView.register(EventTableViewCell.self)
		
		viewModel.loadEvetns()
	}
	
	// MARK: - Binding
	private func bindViewModel() {
		viewModel.events.bindAndFire { [weak self] _ in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
		viewModel.onShowError = { [weak self] alert in
			DispatchQueue.main.async {
				self?.presentSingleButtonDialog(alert: alert)
			}
		}
	}
}

extension EventsViewController: SingleButtonDialogPresenter { }
