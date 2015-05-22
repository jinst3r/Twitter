//
//  TweetCell.swift
//  Twitter
//
//  Created by Jon Choi on 5/21/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var replyButton: UIImageView!
    @IBOutlet weak var retweetButton: UIImageView!
    @IBOutlet weak var favoriteButton: UIImageView!

    var tweet: Tweet! {
        didSet {
            tweetImageView.setImageWithURL(NSURL(string: "\(tweet.user!.profileImageUrl!)"))
            tweetNameLabel.text = tweet.user!.name
            tweetHandleLabel.text = "@\(tweet.user!.screenname!)"
            tweetTimeLabel.text = tweet.createdAtStringUsable!
            tweetContentLabel.text = tweet.text!
            replyButton.image = UIImage(named: "reply")
            retweetButton.image = UIImage(named: "retweet")
            favoriteButton.image = UIImage(named: "favorite")
                
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetImageView.layer.cornerRadius = 4
        tweetImageView.clipsToBounds = true
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tweetContentLabel.preferredMaxLayoutWidth = self.tweetContentLabel.frame.size.width
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tweetContentLabel.preferredMaxLayoutWidth = self.tweetContentLabel.frame.size.width
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
