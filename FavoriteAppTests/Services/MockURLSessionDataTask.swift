//
//  MockURLSessionDataTask.swift
//  FavoriteAppTests
//
//  Created by Ajay Odedra on 25/11/20.
//

import Foundation
@testable import FavoriteApp

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        
    }
}
