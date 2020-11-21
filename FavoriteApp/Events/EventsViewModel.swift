//
//  EventViewModel.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
class EventViewModel {
	
	var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
	let showLoadingHud: Bindable = Bindable(false)
	var events = Bindable([Event]())
	
	let eventService: EventService
	
	init(withEventService eventService: EventService = EventService()) {
			self.eventService = eventService
	}
	
	func loadEvetns(){
		eventService.fetch { (result) in
			switch result{
			case .success(let response):
				self.events.value = response.events
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
