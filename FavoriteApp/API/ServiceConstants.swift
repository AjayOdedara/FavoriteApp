//
//  APIConstants.swift
//  Checkk24TechTest
//
//  Created by Ajay Odedra on 20/09/20.
//  Copyright © 2020 Ajay Odedra. All rights reserved.
//

import Foundation
struct ServiceConstants {
	
	static let base = "https://us-central1-techtaskapi.cloudfunctions.net"
	
	public struct urls {
		public static let events = "/events?"
	}
	
	public struct parameters {
		static let page: String = "page"
		static let limit: String = "limit"
	}
}
