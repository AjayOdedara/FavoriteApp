//
//  EventTableViewCell.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 20/11/20.
//


import UIKit

class EventTableViewCell: UITableViewCell, Reusable {
	
	@IBOutlet weak var eventTitle: UILabel!
	@IBOutlet weak var eventDate: UILabel!
	@IBOutlet weak var favoriteBtn: UIButton!
	@IBOutlet weak var eventImageView: UIImageView!
	
	override func awakeFromNib() {
		selectionStyle = .none
	}
	
	var model: Event? {
		didSet {
			bindViewModel()
		}
	}
	
	func bindViewModel() {
		
		guard let model = model else {
			return
		}
		let titleText = (model.isFavorite ?? false) ? "Unfavorite" : "Favorite"
		favoriteBtn.setTitle(titleText, for: .normal)
		eventTitle.text = model.title
		eventDate.text = "\(model.startDate)"
		eventImageView.setImage(with: URL(string:model.image))
	}
}
