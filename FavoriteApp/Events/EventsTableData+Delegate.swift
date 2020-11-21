//
//  HomeViewTableDataSourceDelegate.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 20/11/20.
//

import UIKit

// MARK: - TableView DataSource
extension EventsViewController {
 
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.events.value.count
  }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: EventViewConstants.CellIdentifier.tableViewEvents, for: indexPath) as? EventTableViewCell else {
      return UITableViewCell()
    }
    return cell
  }
  
}
// MARK: - TableView Delegate
extension EventsViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
}
