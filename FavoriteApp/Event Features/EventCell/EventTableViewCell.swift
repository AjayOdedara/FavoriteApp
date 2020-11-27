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
	@IBOutlet weak var eventHolderView: UIView!
	
	override func awakeFromNib() {
		selectionStyle = .none
		eventHolderView.layer.cornerRadius = 8
		eventImageView.layer.cornerRadius = 8
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
		let titleText = (model.isFavorite ?? false) ? EventViewConstants.EventCellView.unFavoriteState : EventViewConstants.EventCellView.favoriteState
		favoriteBtn.setTitle(titleText, for: .normal)
		eventTitle.text = model.title
		eventDate.text = model.formattedDataAndTime
		eventImageView.setImage(with: model.imageUrl)
	}
}
