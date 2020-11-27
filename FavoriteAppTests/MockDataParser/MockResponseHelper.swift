//
//  MockResponseHelper.swift
//  FavoriteAppTests
//
//  Created by Ajay Odedra on 25/11/20.
//

import Foundation

enum MockResponseType: String {
	case invalidJsonResponse = "EventListInvalidResponse"
	case validJsonResponse = "EventListValidResponse"
	case emptyJsonResponse = "EventListEmptyResponse"
}

class MockResponseHelper {
	
	func processJsonData(for responseType: MockResponseType) -> Data {
		guard let path = Bundle(for: type(of: self)).url(forResource: responseType.rawValue, withExtension: "json"),
			let result = try? Data(contentsOf: path) else { return Data() }
		return result
	}
}
