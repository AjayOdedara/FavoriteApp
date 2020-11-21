//
//  EventService.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation

class EventService: BaseService {
		
		func fetch (completionHandler: @escaping (Result<EventServiceResponse, FetchError>) -> Void) {
				
				fetch(listOf: EventServiceResponse.self, withURL: url(withPath: ServiceConstants.url.events)) { (result) in
						switch result {
						case .success(let events):
								completionHandler(Result.success(events))
						case .failure(let error):
								completionHandler(Result.failure(error))
						}
				}
		}
}