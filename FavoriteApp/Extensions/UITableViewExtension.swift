//
//  UITalbeViewExtension.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import UIKit


protocol Reusable: class {}

extension Reusable where Self: UIView {
	
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}

extension UITableView {
	
	func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
		register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
	}
	
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
		return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T ?? T()
	}
}
