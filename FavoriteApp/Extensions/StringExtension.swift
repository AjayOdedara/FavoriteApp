//
//  StringExtension.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 25/11/20.
//

import Foundation

extension String {
		var localized: String {
				return NSLocalizedString(self, comment: "")
		}
}
