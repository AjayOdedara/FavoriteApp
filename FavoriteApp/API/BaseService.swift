//
//  BaseService.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation

class BaseService {
	lazy var page = 1
	var session: URLSession
	
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
	
	internal func url(withPath path: String) -> URL? {
		return URL(string: ServiceConstants.base + path + ServiceConstants.parameters.page + "=" + "\(page)")
	}
	
	typealias ResultBlock<T> = (Result <T, Error>) -> Void
	
	/**
	* Use to call Api with given response data type
	* Need to pass url
	- Parameter url: Url of event which will extened with page
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
				completionHandler(.failure(.networkFailed))
				return
			}
			
			/// `Parse` Json
			guard let jsonData = data else {
				completionHandler(.failure(.invalidJSON))
				return
			}
			
			/// `Decode` Json
			let json = JSONDecoder()
			do {
				let decodedData: T = try json.decode(T.self, from: jsonData)
				self.page += 1
				completionHandler(.success(decodedData))
			} catch {
				completionHandler(.failure(.decodingError))
			}
			
		})
		
		task.resume()
	}
	
}
