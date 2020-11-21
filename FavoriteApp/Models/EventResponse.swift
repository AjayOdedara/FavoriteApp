//
//  EventResponse.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation

// MARK: - EventResponse
struct EventServiceResponse: Decodable {

	let page, pageSize, total: Int
	let events: [Event]
	
	enum CodingKeys: String, CodingKey {
		case page, pageSize, total
		case events = "items"
	}
}

// MARK: - Event
struct Event: Decodable {

	let id, title: String
	let image: String
	let startDate: Int

	var imageUrl: URL? {
		return URL(string: image)
	}
}
