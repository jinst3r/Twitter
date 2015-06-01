//
//  AccountCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/31/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {


    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenname: UILabel!
    
    var currUser: User! {
        didSet {
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.setImageWithURL(NSURL(string: "\(User.currentUser!.profileImageUrl!)"))
        username.text = User.currentUser!.name!
        screenname.text = String("@\(User.currentUser!.screenname!)")
        profileImageView.layer.cornerRadius = 6
        profileImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
