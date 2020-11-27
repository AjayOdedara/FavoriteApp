//
//  FetchError.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation

enum ServiceFetchError: Error {
	case invalidJSON
	case decodingError
	case invalidURL
	case networkFailed
	case limit
}
