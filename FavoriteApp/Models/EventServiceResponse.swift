//
//  EventServiceResponse.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation

// MARK: - EventResponse
class EventServiceResponse: Decodable {
	
	let page, pageSize, total: Int
	let events: [Event]?
	
	enum CodingKeys: String, CodingKey {
		case page, pageSize, total
		case events = "items"
	}
}
