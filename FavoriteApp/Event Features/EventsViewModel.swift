//
//  EventViewModel.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
class EventViewModel {
	
	enum EventTableViewCellType {
		case normal(model: Event)
		case error(message: String)
		case empty
	}
	
	let eventsCells = Bindable([EventTableViewCellType]())
	var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
	var showLoadingHud: Bindable = Bindable(false)
	
	let eventService: EventService
	
	init(withEventService eventService: EventService = EventService()) {
		self.eventService = eventService
	}
	
	func loadEvetns() {
		self.showLoadingHud.value = true
		eventService.fetch { [weak self] (result) in
			
			switch result{
			case .success(let response):
				
				guard response.events.count < 0 else {
					self?.eventsCells.value = [.empty]
					self?.showLoadingHud.value = false
					return
				}
				self?.saveResponseForOffline(responseEvents: response.events)
				self?.loadResponse(responseEvents: response.events)
				
			case .failure(let error):
				self?.eventsCells.value = [.error(message: error.localizedDescription.debugDescription )]
			}

			self?.showLoadingHud.value = false
		}
	}
	
	func saveResponseForOffline(responseEvents: [Event]) {
		let realm = RealmService.instance
		responseEvents.forEach { (event) in
			// Keep as fav if it's favorite in Database
			let wasFavoriteState = realm.favoriteProducts.filter({$0.isFavorite}).map({$0.id}).contains(event.id)
			
			realm.addOrUpdateEvents(event: Event(id: event.id, title: event.title, image: event.image, startDate: event.startDate, isFavorite: wasFavoriteState))
		}
	}
	func loadResponse(responseEvents: [Event]){
		let realm = RealmService.instance
		let mappedEvents = realm.favoriteProducts
			
			.map{Event(id: $0.id, title: $0.title, image: $0.image, startDate: $0.startDate, isFavorite: $0.isFavorite)}
			.filter{
				responseEvents
				.map{$0.id}.contains($0.id)}
			
		self.eventsCells.value.append(contentsOf: mappedEvents.compactMap {
			.normal(model: $0 as Event)
		})
	}
	func loadDataForOffiline(){
		let realm = RealmService.instance
		let mappedEvents = realm.favoriteProducts.map{Event(id: $0.id, title: $0.title, image: $0.image, startDate: $0.startDate, isFavorite: $0.isFavorite)}
		self.eventsCells.value = mappedEvents.compactMap {
			.normal(model: $0 as Event)
		}
	}
}

extension EventViewModel {
	
	func isLastIndexOfTable(index: Int) -> Bool {
		return eventsCells.value.count - 1 == index
	}
	
	func updateFavoriteState(index: Int) {
		
		let newValue = self.eventsCells.value[index]
		switch newValue {
		case .normal(model: let event):
			event.isFavorite = !(event.isFavorite ?? false)
			DLog("ID = \(event.title) \nFav = \(String(describing: event.isFavorite))")
			let realm = RealmService.instance
			realm.addOrUpdateEvents(event: event)
		default:
			DLog("empty or error type cell")
		}
		self.eventsCells.value[index] = newValue
	
	}
}
