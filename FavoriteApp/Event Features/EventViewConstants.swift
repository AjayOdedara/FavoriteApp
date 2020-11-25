//
//  EventViewConstants.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
struct EventViewConstants {
	
	struct View {
		static let navigationTitle = "event_list_navigation_bar_title".localized
	}
	
	struct EventCellView {
		static let favoriteState = "event_favorite_state".localized
		static let unFavoriteState = "event_unfavorite_state".localized
	}
	
	struct AlertView {
		static let defaultMessgae = "api_failure".localized
		static let emptyDataMessgae = "api_empty_data_messgae".localized
		static let alertTitle = "alert_error_title".localized
		static let alertOkayButtonTitle = "alert_okay_title".localized
	}
	
	struct CellIdentifier {
		static let tableViewEvents = "EventTableViewCell"
		static let tableViewErrorCell = "EventTableErrorCell"
	}
	
}
