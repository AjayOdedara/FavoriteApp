//
//  EventViewModel.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
import Network

class EventViewModel {
	
	enum EventTableViewCellType {
		case normal(model: Event)
		case error(message: String)
	}
	
	let eventsCells = Bindable([EventTableViewCellType]())
	var showLoadingHud: Bindable = Bindable(false)
	var isInternetAvailable: Bool = false
	let networkMonitor = NWPathMonitor()
	var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
	
	private let eventService: EventService
	
	init(withEventService eventService: EventService = EventService()) {
		self.eventService = eventService
	}
	
	func loadEvetns() {
		
		self.showLoadingHud.value = true
		eventService.fetch { [weak self] (result) in
			
			switch result {
			case .success(let response):
				
				guard let events = response.events, events.count > 0 else {
					// Show empty data alert
					self?.showLoadingHud.value = false
					let alert = SingleButtonAlert(title: EventViewConstants.AlertView.alertTitle,
												  message: EventViewConstants.AlertView.emptyDataMessgae,
												  action: AlertAction(buttonTitle: EventViewConstants.AlertView.alertOkayButtonTitle, handler: {
						DLog("Alert action clicked")
					}))
					self?.onShowError?(alert)
					
					return
				}
				
				self?.saveResponse(toDatabase: response.events ?? [])
				self?.loadResponse(data: response.events ?? [])
				
			case .failure(let error):
				self?.eventsCells.value = [.error(message: error.localizedDescription.debugDescription )]
			}
			
			self?.showLoadingHud.value = false
		}
	}
	
	// Network State Monitor
	func initNetworkCheckAndLoadData() {
		
		networkMonitor.pathUpdateHandler = { [weak self] pathUpdateHandler in
			if pathUpdateHandler.status == .satisfied {
				self?.isInternetAvailable = true
				self?.loadEvetns()
			} else {
				self?.isInternetAvailable = false
				self?.retriveOfflineData()
			}
		}
		
		let queue = DispatchQueue(label: "InternetConnectionMonitor")
		networkMonitor.start(queue: queue)
	}
	
	deinit {
		networkMonitor.cancel()
	}
}

// MARK: - Manager Event Data
extension EventViewModel{
	
	func saveResponse(toDatabase events: [Event]) {
		
		let realm = RealmService.instance
		events.forEach { (event) in
			// Keep as fav if it's favorite in Database: Give true or false in variable
			let wasFavoriteState = realm.events.filter({$0.isFavorite}).map({$0.id}).contains(event.id)
			
			realm.updateOffline(data: Event(id: event.id,
											title: event.title,
											image: event.image,
											startDate: event.startDate,
											isFavorite: wasFavoriteState))
		}
	}
	
	func loadResponse(data events: [Event]) {
		
		let eventsInDatabase = RealmService.instance.events
		let mappedEvents = eventsInDatabase
			.map {Event(id: $0.id,
						title: $0.title,
						image: $0.image,
						startDate: $0.startDate,
						isFavorite: $0.isFavorite)}
			.filter { events
				.map {$0.id}.contains($0.id)}
		
		self.eventsCells.value.append(contentsOf: mappedEvents.compactMap {
			.normal(model: $0 as Event)
		})
	}
	
	func retriveOfflineData() {
		
		let eventsInDatabase = RealmService.instance.events
		
		let mappedEvents = eventsInDatabase.map {Event(id: $0.id,
													   title: $0.title,
													   image: $0.image,
													   startDate: $0.startDate,
													   isFavorite: $0.isFavorite)}
		
		self.eventsCells.value = mappedEvents.compactMap {
			.normal(model: $0 as Event)
		}
	}
}

extension EventViewModel {
	
	func isLastIndexOfTable(index: Int) -> Bool {
		return eventsCells.value.count - 1 == index
	}
	
	func updateEventFavoriteState(at index: Int) {
		
		let newValue = self.eventsCells.value[index]
		switch newValue {
		case .normal(model: let event):
			event.isFavorite = !(event.isFavorite ?? false)
			RealmService.instance.updateStateOf(event: event)
		default:
			DLog("Something went wrong in loading data")
		}
		self.eventsCells.value[index] = newValue
	
	}
}
