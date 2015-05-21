//
//  RetweetAndFavoriteCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class RetweetAndFavoriteCell: UITableViewCell {

    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
