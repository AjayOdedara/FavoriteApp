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
	var session: URLSession = .shared
	let url = URL(string: "http://www.github.com")!
	var error: FetchError?
	
	override class func setUp() {
		super.setUp()
		sut = BaseService()
		error = nil
	}

}
