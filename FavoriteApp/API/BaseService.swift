//
//  BaseService.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation

class AppServerClient {
	
	var session: URLSession
	
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
	
	typealias ResultBlock<T> = (Result <T, Error>) -> Void
	/**
	* Use to call Api with given response data type
	* Need to pass url with it
	- Parameter url: Url of product data
	*/
	func fetch<T: Decodable>(listOf representable: T.Type,
													 withURL url: URL?,
													 completionHandler: @escaping (Result<T, FetchError>) -> Void) {
		
		guard let url = url else {
			completionHandler(.failure(.invalidURL))
			return
		}
		
		let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { (data, _, error) -> Void in
			guard error == nil else {
				DispatchQueue.main.async {
					completionHandler(.failure(.networkFailed))
				}
				return
			}
			/// `Parse` JSON
			guard let jsonData = data else {
				DispatchQueue.main.async {
					completionHandler(.failure(.invalidJSON))
				}
				return
			}
			/// `Decode` json
			let json = JSONDecoder()
			do {
				let decodedData: T = try json.decode(T.self, from: jsonData)
				//completion(.success(decodedData))
				DispatchQueue.main.async {
					completionHandler(.success(decodedData))
				}
			} catch {
				DispatchQueue.main.async {
					completionHandler(.failure(.decodingError))
				}
			}
		})
		task.resume()
	}
	
}
