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

// MARK: - Event
class Event: Decodable {
	
	var id, title: String
	var image: String
	var startDate: Int
	var isFavorite: Bool?
	var imageUrl: URL? {
		return URL(string: image)
	}
	
	init(id: String, title: String, image: String, startDate: Int, isFavorite: Bool) {
		self.id = id
		self.title = title
		self.image = image
		self.startDate = startDate
		self.isFavorite = isFavorite
	}
}
