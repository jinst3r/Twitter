//
//  ReplyRetweetFavoriteCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class ReplyRetweetFavoriteCell: UITableViewCell {

    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func replyButtonTapped(sender: AnyObject) {
    }
    @IBAction func retweetButtonTapped(sender: AnyObject) {
    }
    @IBAction func favoriteButtonTapped(sender: AnyObject) {
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
