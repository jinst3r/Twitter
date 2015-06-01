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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            profileImageView.setImageWithURL(NSURL(string: "\(tweet.user!.profileImageUrl!)"))
            if tweet.user!.backgroundImageUrl != nil {
                backgroundImageView.setImageWithURL(NSURL(string: "\(tweet.user!.backgroundImageUrl!)"))
            }
            userNameLabel.text = tweet.user!.name
            userHandleLabel.text = "@\(tweet.user!.screenname!)"
            userDescriptionLabel.text = tweet.user!.tagline
            userLocationLabel.text = tweet.user!.location
            
            if (tweet.user!.followingsCount! >= 1000000) {
                followingCountLabel.text = String("\(tweet.user!.followingsCount!/1000000)M")
            } else if (tweet.user!.followingsCount! >= 1000) {
                followingCountLabel.text = String("\(tweet.user!.followingsCount!/1000)K")
            } else {
                followingCountLabel.text = String("\(tweet.user!.followingsCount!)")
                println("\(tweet.user!.followingsCount!)")
            }
            if (tweet.user!.followersCount! >= 1000000) {
                followersCountLabel.text = String("\(tweet.user!.followersCount!/1000000)M")
            } else if (tweet.user!.followersCount! >= 1000) {
                followersCountLabel.text = String("\(tweet.user!.followersCount!/1000)K")
            } else {
                followersCountLabel.text = String("\(tweet.user!.followersCount!)")
            }
            if (tweet.user!.tweetsCount! >= 1000000) {
                tweetCountLabel.text = String("\(tweet.user!.tweetsCount!/1000000)M")
            } else if (tweet.user!.tweetsCount! >= 1000) {
                tweetCountLabel.text = String("\(tweet.user!.tweetsCount!/1000)K")
            } else {
                tweetCountLabel.text = String("\(tweet.user!.tweetsCount!)")
            }
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
