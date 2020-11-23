//
//  TableViewHeader.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 21/11/20.
//

import UIKit
class TableViewPageLoader: UIView {
	
	@IBOutlet weak var loader: UIActivityIndicatorView!
	
	class func instanceFromNib() -> TableViewPageLoader {
		return UINib(nibName: "TableViewPageLoader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TableViewPageLoader
	}
}
