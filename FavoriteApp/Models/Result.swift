//
//  Result.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import Foundation
enum Result<T, E: Error> {
		case success(T)
		case failure(E)
}
