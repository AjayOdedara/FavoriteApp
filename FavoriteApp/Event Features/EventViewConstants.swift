//
//  EventViewConstants.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
struct EventViewConstants {
	
	struct View {
		static let navigationTitle = NSLocalizedString("event_list_navigation_bar_title", comment: "events navigation title")
	}
	
	struct AlertView {
		static let defaultMessgae = NSLocalizedString("api_failure", comment: "Default api failure message")
		static let emptyDataMessgae = NSLocalizedString("api_empty_data_messgae", comment: "Api failure message for empty data")
		static let alertTitle = NSLocalizedString("alert_error_title", comment: "Alert title for failure")
		static let alertOkayButtonTitle = NSLocalizedString("alert_okay_title", comment: "Alert okay button title for failure")
	}
	
	struct CellIdentifier {
		static let tableViewEvents = "EventTableViewCell"
		static let tableViewErrorCell = "EventTableErrorCell"
	}
	
}
