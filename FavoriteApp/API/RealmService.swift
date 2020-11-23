//
//  RealmService.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//


import Foundation
import RealmSwift

@objcMembers class EventData: Object{
	dynamic var id: String = ""
	dynamic var title: String = ""
	dynamic var image: String = ""
	dynamic var startDate: Int = 0
	dynamic var isFavorite: Bool = false
	override static func primaryKey() -> String? {
		return "id"
	}
	
}
extension Object {
	func updateToRealm() {
		RealmService.instance.update(self)
	}
}
class RealmService {
	
	static let instance = RealmService()
	
	var favoriteProducts: Results<EventData> {
		get {
			return fetchFavorites()
		}
	}
	
	private func fetchFavorites() -> Results<EventData> {
		let results = self.getDataFromRealm(ofType: EventData.self)
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

extension RealmService{
	
	func addOrUpdateEvents(event: Event){
		let data = EventData()
		data.id = event.id
		data.title = event.title
		data.image = event.image
		data.startDate = event.startDate
		data.isFavorite = event.isFavorite ?? false
		do {
			try realm.write{
				realm.add(data, update: .all)
			}
		} catch  {
			DLog("Error while Add/Update event object to realm database")
		}
		//data.updateToRealm()
	}
	func updateState(event: Event){
		do {
			try realm.write{
				favoriteProducts.filter{$0.id == event.id}.first?.isFavorite = event.isFavorite ?? false
			}
		} catch  {
			DLog("Error while updating favorite event to realm database")
		}
		
	}
}
