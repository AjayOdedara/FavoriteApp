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

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T ?? T()
    }
}
