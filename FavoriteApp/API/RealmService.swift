//
//  RealmService.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
import RealmSwift

class RealmService {
	
	static let instance = RealmService()
	
	var events: Results<EventRealmData> {
		get {
			return fetchEvents()
		}
	}
	
	private func fetchEvents() -> Results<EventRealmData> {
		let results = self.getDataFromRealm(ofType: EventRealmData.self)
		return results
	}
	
	private func getDataFromRealm<T: Object>(ofType: T.Type) -> Results<T> {
		let results: Results<T> = realm.objects(ofType)
		return results
	}
	
	func update<T: Object>(_ object: T) {
		do {
			try realm.write {
				realm.add(object, update: Realm.UpdatePolicy.all)
			}
		} catch {
			DLog("update \(error.localizedDescription)")
		}
	}
	
	private var realm: Realm {
		get {
			do {
				let realm = try Realm()
				return realm
			} catch let error as NSError {
				DLog("[RealmService] Realm init error \(error)")
			}
			return self.realm
		}
	}
}

extension RealmService {
	
	func updateOffline(data event: Event) {
		
		let data = EventRealmData()
		data.id = event.id
		data.title = event.title
		data.image = event.image
		data.startDate = event.startDate
		data.isFavorite = event.isFavorite ?? false
		self.update(data)
	}
	
	func updateStateOf(event: Event) {
		
		do {
			try realm.write {
				events.filter {$0.id == event.id}.first?.isFavorite = event.isFavorite ?? false
			}
		} catch {
			DLog("Error while updating favorite event to realm database")
		}
	}
}
