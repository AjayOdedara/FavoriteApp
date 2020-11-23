//
//  EventTableViewCell.swift
//  FavoriteApp
//
//  Created by Ajay Odedra on 20/11/20.
//


import UIKit

class InfoTableViewCell: UITableViewCell, Reusable {
	
	@IBOutlet weak var infoMessage: UILabel!
	@IBOutlet weak var retryBtn: UIButton!
	@IBOutlet weak var infoImage: UIImageView!
	
	override func awakeFromNib() {
		selectionStyle = .none
	}
}
