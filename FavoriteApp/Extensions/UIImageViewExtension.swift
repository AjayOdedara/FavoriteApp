//
//  UIImageViewExtension.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import UIKit
import Kingfisher

extension UIImageView {
	func setImage(with url: URL?) {
		kf.setImage(with: url)
	}
}
