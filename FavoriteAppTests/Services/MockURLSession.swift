//
//  MockURLSession.swift
//  FavoriteAppTests
//
//  Created by Ajay Odedra on 25/11/20.
//

import XCTest
import Foundation
@testable import FavoriteApp

class MockURLSession: URLSessionProtocol {
    private (set) var lastURL: URL?
    var nextDataTask = MockURLSessionDataTask()
    var nextResponse: HTTPURLResponse?
    var nextData: Data?
    var nextError: ServiceFetchError?
    
    func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
}
