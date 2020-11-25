//
//  EventsViewController.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 20/11/20.
//

import UIKit
import Network


class EventsViewController: UITableViewController {
	
	lazy var viewModel: EventViewModel = {
		return EventViewModel()
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		bindViewModel()
		viewModel.initNetworkCheck()
	}
	
	// MARK: - View Setup
	private func configureUI() {
		
		self.title = EventViewConstants.View.navigationTitle
		
		tableView.tableFooterView = UIView()
		tableView.estimatedRowHeight = 150
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
		tableView.register(EventTableViewCell.self)
		tableView.register(InfoTableViewCell.self)
	}
	
	// MARK: - Binding
	private func bindViewModel() {
		viewModel.eventsCells.bindAndFire { [weak self] _ in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
		viewModel.onShowError = { [weak self] alert in
			DLog("Got an error while loading events")
			DispatchQueue.main.async {
				self?.presentSingleButtonDialog(alert: alert)
			}
		}
	}
	
	// MARK: - TableView Button Action
	@objc func updateFavoriteState(sender: UIButton) {
		viewModel.updateFavoriteState(index: sender.tag)
	}
	
	@objc func tryReloadAgain(sender: UIButton) {
		viewModel.loadEvetns()
	}
}

// MARK: - TableView DWorldataSource
extension EventsViewController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.eventsCells.value.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		switch viewModel.eventsCells.value[indexPath.row] {
		case .normal(_):
			return tableView.dequeueReusableCell(forIndexPath: indexPath) as EventTableViewCell
		case .error(_):
			return tableView.dequeueReusableCell(forIndexPath: indexPath) as InfoTableViewCell
		}
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		switch viewModel.eventsCells.value[indexPath.row] {
		case .normal(let model):

			guard let cell = cell as? EventTableViewCell else { return }
			cell.favoriteBtn.tag = indexPath.row
			cell.favoriteBtn.addTarget(self, action: #selector(updateFavoriteState(sender:)), for: .touchUpInside)
			cell.model = model
			
			if self.viewModel.isLastIndexOfTable(index: indexPath.row) {
				viewModel.isInternetAvailable ? self.viewModel.loadEvetns() : DLog("No internet - Data already loaded")
			}
			
		case .error(let message):
			guard let cell = cell as? InfoTableViewCell else { return }
			cell.infoMessage.text = message
			cell.infoImage.image = UIImage(systemName: "exclamationmark.triangle")
			cell.retryBtn.addTarget(self, action: #selector(tryReloadAgain(sender:)), for: .touchUpInside)

		}
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footerView = TableViewPageLoader.instanceFromNib()
		viewModel.showLoadingHud.value ? footerView.loader.startAnimating() : footerView.loader.stopAnimating()
		return footerView
	}
}

// MARK: - Alert
extension EventsViewController: SingleButtonDialogPresenter { }
