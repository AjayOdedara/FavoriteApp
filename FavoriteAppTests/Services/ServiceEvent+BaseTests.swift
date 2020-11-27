//
//  ServiceBaseTests.swift
//  FavoriteAppTests
//
//  Created by Ajay Odedra on 25/11/20.
//

import XCTest
import Foundation
@testable import FavoriteApp

class BaseServiceTests: XCTestCase {
	
	var sut: BaseService!
	var session = MockURLSession()
	let url = URL(string: "http://www.github.com")!
	var error: ServiceFetchError?
	
	override func setUp() {
		super.setUp()
		sut = BaseService(session: session)
		error = nil
	}
	
	func testSessionURL() {
		sut.fetch(listOf: EventServiceResponse.self, withURL: url) { (_) in}
		XCTAssert(session.lastURL == url)
	}
	
	func testResponseError() {
		sut.fetch(listOf: EventServiceResponse.self, withURL: url) { (result) in
			switch result {
			case .success(let events):
				XCTAssertNil(events)
			case .failure(let error):
				XCTAssertNotNil(error)
			}
		}
	}
	
	func testResumeCalled() {
		let dataTask = MockURLSessionDataTask()
		session.nextDataTask = dataTask
		
		sut.fetch(listOf: EventServiceResponse.self, withURL: url) { (_) in}
		
		XCTAssert(dataTask.resumeWasCalled)
	}
	
	func testInvalidURL() {
		
		sut.fetch(listOf: EventServiceResponse.self, withURL: nil) { (response) in
			switch response {
			case .failure(let error):
				XCTAssertEqual(error, ServiceFetchError.invalidURL)
			default: break
			}
		}
	}

	func testWithError() {
		session.nextError = .networkFailed
		sut.fetch(listOf: EventServiceResponse.self, withURL: url) { (response) in
			switch response {
			case .failure(let error):
				XCTAssertEqual(error, .networkFailed)
			default: break
			}
		}
	}
	
	func testInvalidResponse() {
		
		let exp = expectation(description: "Got an Invalid response")

		session.nextData = MockResponseHelper().processJsonData(for: .invalidJsonResponse)
		sut.fetch(listOf: EventServiceResponse.self, withURL: url) { (result) in
			switch result {
			case .success(let data):
				XCTAssertEqual(data.events?.count ?? -1, 0)
			case .failure(let error):
				XCTAssertTrue(error == .decodingError)
			}
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func testValidResponse() {
		
		let exp = expectation(description: "Got valid response")

		session.nextData = MockResponseHelper().processJsonData(for: .validJsonResponse)
		sut.fetch(listOf: EventServiceResponse.self, withURL: url) { (response) in
			switch response {
			case .success(let data):
				XCTAssertFalse(data.events?.isEmpty ?? true)
			case .failure(let error):
				XCTAssertNil(error)
			}
			exp.fulfill()
		}
		
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
}
