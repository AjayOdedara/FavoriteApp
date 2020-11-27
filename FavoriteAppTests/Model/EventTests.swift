//
//  EventViewModelTests.swift
//  EventTests
//
//  Created by Ajay Odedra on 26/11/20.
//

import XCTest
@testable import FavoriteApp

class EventTests: XCTestCase {
	
	var event: Event? {
		return DecodableHelper.decode(Event.self, dictionary: eventDataPresentation())
	}
	func testInitializationWithRepresentation() {
		XCTAssertNotNil(event)
	}
	
	func testInitializationWithNoImagePathRepresentation() {
		let eventDataNilImagePresentation = [
			"id": "5d4aab8b4ada8fca84541eee",
			"title": "Morton Orr",
			"startDate": 1567926806
		] as [String: Any]
		
		XCTAssertNil(DecodableHelper.decode(Event.self, dictionary: eventDataNilImagePresentation))
	}
	
	func testNameDescriptionAndThumbnail() throws {
		let event = try XCTUnwrap(self.event)

		XCTAssertTrue(event.id == "5d4aab8b4ada8fca84541eee")
		XCTAssertTrue(event.title == "Morton Orr")
		XCTAssertTrue(event.startDate == 1567926806)
		XCTAssertTrue(event.image == "https://s3-eu-west-1.amazonaws.com/bstage/plans/D7L4RQ3XAYNCPW65KB8S.jpg")
	}
	
}

extension EventTests {
	
	private func eventDataPresentation() -> [String: Any] {
		let representation = [
			"id": "5d4aab8b4ada8fca84541eee",
			"title": "Morton Orr",
			"image": "https://s3-eu-west-1.amazonaws.com/bstage/plans/D7L4RQ3XAYNCPW65KB8S.jpg",
			"startDate": 1567926806
			] as [String: Any]
		return representation
	}
}
