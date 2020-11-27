//
//  Event.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 26/11/20.
//

import Foundation

// MARK: - Event
class Event: Decodable {
	
	var id, title: String
	var image: String
	var startDate: Int
	var isFavorite: Bool?
	
	var formattedDataAndTime: String {
		
		let date = Date(timeIntervalSince1970: TimeInterval(startDate))
		
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "EEEE, HH:mm"
		
		return dateFormatter.string(from: date)
	}
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
