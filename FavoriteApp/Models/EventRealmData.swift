//
//  EventRealmData.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 24/11/20.
//

import RealmSwift

@objcMembers class EventRealmData: Object {

	dynamic var id: String = ""
	dynamic var title: String = ""
	dynamic var image: String = ""
	dynamic var startDate: Int = 0
	dynamic var isFavorite: Bool = false
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
