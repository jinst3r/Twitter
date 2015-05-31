//
//  ProfileCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/30/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: "\(tweet.user!.profileImageUrl!)"))
            userNameLabel.text = tweet.user!.name
            userHandleLabel.text = "@\(tweet.user!.screenname!)"
            userDescriptionLabel.text = tweet.user!.tagline
            userLocationLabel.text = tweet.user!.location
            followingCountLabel.text = tweet.user!.followingsCount
            followersCountLabel.text = tweet.user!.followersCount
            tweetCountLabel.text = String("\(tweet.user!.tweetsCount!)")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 4
        profileImageView.clipsToBounds = true
        
        dispatch_async(dispatch_get_main_queue()) {
            self.userDescriptionLabel.preferredMaxLayoutWidth = self.userDescriptionLabel.frame.size.width
        }

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.userDescriptionLabel.preferredMaxLayoutWidth = self.userDescriptionLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
